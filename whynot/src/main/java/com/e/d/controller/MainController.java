package com.e.d.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.e.d.model.entity.CreatorEntity;
import com.e.d.model.entity.VideosEntity;
import com.e.d.model.repository.CommentRepository;
import com.e.d.model.repository.CreatorRepository;
import com.e.d.model.repository.LikeRepository;
import com.e.d.model.repository.SubscriptionsRepository;
import com.e.d.model.repository.VideosRepository;
import com.e.d.model.repository.ViewStoryRepository;
import com.e.d.model.service.CommentService;
import com.e.d.model.service.CreatorService;
import com.e.d.model.service.IpService;
import com.e.d.model.service.LikeService;
import com.e.d.model.service.SubscriptionsService;
import com.e.d.model.service.VideosService;
import com.e.d.model.service.ViewStoryService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Controller
public class MainController {

	private final CommentRepository commentRepository;
	private final CreatorRepository creatorRepository;
	private final LikeRepository likeRepository;
	private final SubscriptionsRepository subscriptionsRepository;
	private final VideosRepository videosRepository;
	private final ViewStoryRepository viewStoryRepository;

	private final CommentService commentService;
	private final CreatorService creatorService;
	private final LikeService likeService;
	private final SubscriptionsService subscriptionsService;
	private final VideosService videosService;
	private final ViewStoryService viewStoryService;

	private final IpService ipService;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncode;
	
	@GetMapping("/")
	public String index(Model model) {
		ipService.ipPrint();
		model.addAttribute("allVideo", videosRepository.findAll(Sort.by(Direction.DESC, "videoId")));
		return "index";
	}

	@GetMapping("/search")
	public String searchMethod(@RequestParam String t, Model model) {
		model.addAttribute("searchList", videosService.search(t));
		model.addAttribute("searchWord", t);
		return "video/search";
	}

	@GetMapping("/login")
	public String moveLoginForm() {
		return "creator/login";
	}

	@GetMapping("/signup")
	public String moveSignupForm() {
		return "creator/signup";
	}

	@PostMapping("/loginF")
	public String login(@RequestParam String creatorName, @RequestParam String creatorPassword, HttpSession session) {
		try {
			Optional<CreatorEntity> creatorOpt = creatorService.authenticate(creatorName, creatorPassword);

			if (creatorOpt.isPresent()) {
				CreatorEntity creator = creatorOpt.get();
				session.setAttribute("creatorSession", creator);
				log.info("로그인 성공: 사용자 [{}], ID [{}]", creator.getCreatorName(), creator.getCreatorId());
			} else {
				log.warn("로그인 실패: 사용자 이름 [{}]에 해당하는 계정을 찾을 수 없거나 비밀번호 불일치.", creatorName);
			}
		} catch (IllegalArgumentException e) {
			log.warn("로그인 실패: {}", e.getMessage());
		}

		return "redirect:/";
	}

	@PostMapping("/logout")
	public String logout(HttpSession session) {
		CreatorEntity creator = (CreatorEntity) session.getAttribute("creatorSession");
		if (creator != null) {
			log.info(creator.getCreatorName() + "이 로그아웃함 ( 고유 번호 : " + creator.getCreatorId() + " )");
			session.invalidate();
		}
		return "redirect:/";
	}

	@PostMapping("/signupF")
	public String signup(@RequestParam String creatorName, @RequestParam String creatorEmail, 
			@RequestParam String creatorPassword, @RequestParam String tel, @RequestParam MultipartFile profileImgPath, 
			Model m, HttpSession session) {
		try {
			creatorService.creatorSignupFunction2(creatorName, creatorEmail, creatorPassword, tel, profileImgPath, session);
			m.addAttribute("success", "회원가입에 성공 했습니다.");
		} catch (IOException e) {
			e.printStackTrace();
			m.addAttribute("success", "회원가입에 실패 했습니다.");
		}
		return "success/success";
	}

	@GetMapping("/channel/{creatorName}")
	public String creatorProfile(@PathVariable String creatorName, Model model, HttpSession session) {
		Optional<CreatorEntity> creatorOpt = creatorService.getCreatorProfile(creatorName);
		CreatorEntity user = (CreatorEntity) session.getAttribute("creatorSession");
		CreatorEntity creator = creatorOpt.get();

		if (creatorOpt.isEmpty()) return "redirect:/";

		model.addAttribute("creator", creator);
		model.addAttribute("creatorVideosList", videosService.getCreatorVideos(creator.getCreatorId()));

		if (user != null) {
			boolean isSubscribed = subscriptionsService.isSubscribed(creator.getCreatorId(), user.getCreatorId());
			model.addAttribute("isSubscribed", isSubscribed);
		}

		return "creator/channel";
	}

	@GetMapping("/you")
	public String showCreatorProfile(Model m, HttpSession s) {
		CreatorEntity user = (CreatorEntity) s.getAttribute("creatorSession");
		if (user != null) {
			m.addAttribute("you", creatorRepository.findById(user.getCreatorId()).orElse(null));
			m.addAttribute("myViewStoryButMyPageData", viewStoryService.myViewStorySelect(user.getCreatorId()));
			m.addAttribute("myLikeVideoButMyPageData", videosService.selectByMyLikeVideo(user.getCreatorId()));
		}
		return "me/you";
	}

	@GetMapping("/you/like")
	public String myLikedVideoList(HttpSession session, Model model) {
		CreatorEntity user = (CreatorEntity) session.getAttribute("creatorSession");
		if (user == null) return "creator/login";
		model.addAttribute("myLikeVideo", videosService.selectByMyLikeVideo(user.getCreatorId()));
		return "me/myLikeVideo";
	}
	
	@PostMapping("/editBio")
	public String editBio(HttpSession s, @RequestParam String bio) {
		creatorService.editBio(s, bio);
		return "redirect:/you";
	}
	
	@GetMapping("/you/viewstory")
	public String yourViewStory(HttpSession session, Model m) {
		CreatorEntity user = (CreatorEntity) session.getAttribute("creatorSession");
		if (user == null) return "creator/login";
		m.addAttribute("myViewStory", viewStoryService.myViewStorySelect(user.getCreatorId()));
		return "me/viewstory";
	}

	@GetMapping("/upload")
	public String moveOnUploadForm(HttpSession session) {
		return (session.getAttribute("creatorSession") != null) ? "video/upload" : "creator/login";
	}

	@PostMapping("/uploadVideo")
	public String upload(@RequestParam String tag, @RequestParam String title, @RequestParam String more, @RequestParam String videoLen,
			@RequestParam MultipartFile imgPath, @RequestParam MultipartFile videoPath, HttpSession session) {
		try {
			videosService.uploadVideo(tag, title, more, videoLen, imgPath, videoPath, session);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/";
	}

	@GetMapping("/watch")
	public String watchTheVideo(@RequestParam String v, Model model, HttpSession session) {
		if (session.getAttribute("creatorSession") != null) viewStoryService.viewStoryInsert(v, session);
		try {
			Map<String, Object> videoDetails = videosService.watchVideo(v, session);
			model.addAllAttributes(videoDetails);
			return "video/watch";
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/error";
		}
	}

	@PostMapping("/commentAdd")
	public String addVideoComment(@RequestParam long commentVideo, @RequestParam String commentContent, 
			HttpSession session) throws UnsupportedEncodingException {
		VideosEntity video = videosRepository.findById(commentVideo).get();
		if (session.getAttribute("creatorSession") != null) {
			commentService.commentAdd(commentVideo, session, commentContent);
		}
		return "redirect:/watch?v=" + video.getVideoUrl();
	}

	@PostMapping("/commentEdit")
	public String commentEdit(@RequestParam long commentId, @RequestParam String commentContent, @RequestParam long commentVideo) {
		return commentService.commentEdit(commentId, commentContent, commentVideo);
	}

	@PostMapping("/deleteComment")
	public String deleteComment(@RequestParam long commentId, @RequestParam long videoId) {
		commentService.deleteComment(commentId);
		return "redirect:/watch?v=" + videosRepository.findById(videoId).orElse(null).getVideoUrl();
	}

	@PostMapping("/deleteCommentButAdminAccount")
	public String deleteCommentButAdminAccount(@RequestParam long commentId) {
		commentService.deleteCommentButAdminAccount(commentId);
		return "redirect:/myVideo/comment";
	}

	@PostMapping("/subscri")
	public String subscri(@RequestParam long subscriberId, @RequestParam long subscribingId) {
		return subscriptionsService.subscribe(subscriberId, subscribingId);
	}
	
	@PostMapping("/watchPageSubscri")
	public String watchPageSubscri(@RequestParam long subscriberId, @RequestParam long subscribingId, @RequestParam String videoUrl) {
		return subscriptionsService.watchPageSubscribe(subscriberId, subscribingId, videoUrl);
	}

	@PostMapping("/deleteSubscri")
	public String deleteMySubscri(@RequestParam long subscriberId, HttpSession session) {
		if (session.getAttribute("creatorSession") == null) return "redirect:/login";
		subscriptionsService.unsubscribe(subscriberId, session);
		return "redirect:/mySubscri";
	}

	@GetMapping("/tag/{tag}")
	public String hashTag(@PathVariable String tag, Model model) {
		List<VideosEntity> videoTagList = videosRepository.findByTagContainingOrderByVideoIdDesc(tag);
		model.addAttribute("videosTagList", videoTagList);
		model.addAttribute("tagWord", tag);
		return "tag/tag";
	}

	@GetMapping("/mySubscri")
	public String mySubscribingChannelsList(HttpSession session, Model model) {
		if (session.getAttribute("creatorSession") == null) return "creator/login";
		model.addAttribute("mySubscribers", subscriptionsService.mySubscribingChannelsList(session));
		return "creator/mySubscriChannel";
	}

	@GetMapping("/myVideo")
	public String myVideo(HttpSession session, Model m) {
		CreatorEntity user = (CreatorEntity) session.getAttribute("creatorSession");
		if (user == null) return "creator/login";
		m.addAttribute("myvideos", videosRepository.findByCreatorVal(user.getCreatorId()));
		return "dashboard/myVideo";
	}

	@GetMapping("/myVideo/dashboard")
	public String dashboardPage(HttpSession session, Model m) {
		CreatorEntity user = (CreatorEntity) session.getAttribute("creatorSession");
		if (user == null) return "creator/login";

		if (videosRepository.countByCreatorVal(user.getCreatorId()) != 0) {
			m.addAttribute("countMyVideos", videosRepository.countByCreatorVal(user.getCreatorId())); // 내가 올린 영상
			m.addAttribute("commentCntMyVideos", commentRepository.countByCommentUserid(user.getCreatorId())); // 내 영상에 작성된 모든 댓글 갯수
			m.addAttribute("sumMyVideosLikes", videosService.sumByMyVideoLikes(user.getCreatorId())); // 내가 올린 영상의 모든 좋아요 수
			m.addAttribute("sumMyVideosViews", videosService.sumByMyVideoViews(user.getCreatorId())); // 내가 올린 영상의 모든 조회수
		}

		return "dashboard/dashboard";
	}

	@GetMapping("/myVideo/myComment")
	public String myAllComment(HttpSession session, Model m) {
		CreatorEntity user = (CreatorEntity) session.getAttribute("creatorSession");
		if (user == null) return "creator/login";
		
		m.addAttribute("myAllComment", commentService.findMyAllComment(user.getCreatorId()));
		return "dashboard/myComment";
	}

	@GetMapping("/myVideo/comment")
	public String myVideoComment(HttpSession session, Model m) {
		CreatorEntity user = (CreatorEntity) session.getAttribute("creatorSession");
		if (user == null) return "creator/login";
		
		m.addAttribute("myVideoCommentList", commentService.selectByMyAllVideoCommentList(user.getCreatorId()));
		return "dashboard/videoAllComment";
	}

	@GetMapping("/myVideo/subscribe")
	public String myVideoSubscribe(HttpSession session, Model m) {
		if (session.getAttribute("creatorSession") == null) return "creator/login";
		m.addAttribute("mySubscribeLists", subscriptionsService.myVideoSubscribe(session));
		return "dashboard/subscribe";
	}

	@PostMapping("/myVideoDelete")
	public String myVideoDelete(HttpSession session, @RequestParam long videoId) {
		videosService.myVideoDelete(videoId, session);
		return "redirect:/myVideo";
	}

	@PostMapping("/myVideoUpdate")
	public String myVideoUpdate(HttpSession session, @RequestParam long videoId, Model m) {
		CreatorEntity user = (CreatorEntity) session.getAttribute("creatorSession");
		Optional<VideosEntity> video = videosRepository.findById(videoId);

		if (user == null) return "creator/login";
		if (video.isPresent() && user != null && user.getCreatorId() == video.get().getCreatorVal()) {
			m.addAttribute("updatingVideo", video.get());
			return "creator/myVideoUpdate";
		}
		return "redirect:/myVideo";
	}

	@PostMapping("/updateVideo")
	public String updateVideo(@RequestParam long videoId, @RequestParam String creatorName, @RequestParam String tag,
			@RequestParam String title, @RequestParam String more, @RequestParam MultipartFile imgPath,
			@RequestParam MultipartFile videoPath, @RequestParam String videoLen, @RequestParam String currentImgPath,
			@RequestParam String currentVideoPath, HttpSession session) {
		videosService.updateVideo(videoId, creatorName, tag, title, more, imgPath, videoPath, videoLen, currentImgPath, currentVideoPath, session);
		return "redirect:/myVideo";
	}

	@GetMapping("/update")
	public String updateMeMovePage(HttpSession s, Model m) {
		return s.getAttribute("creatorSession") != null ? "creator/updateMe" : "index";
	}

	@PostMapping("/confirmPassword")
	public String confirmPassword(@RequestParam String creatorPassword, HttpSession s, Model m) {
		CreatorEntity user = (CreatorEntity) s.getAttribute("creatorSession");
		Optional<CreatorEntity> userInfo = creatorRepository.findById(user.getCreatorId());
		if (user != null && userInfo.isPresent() && passwordEncode.matches(creatorPassword, user.getCreatorPassword())) {
			m.addAttribute("creatorInfomation", userInfo.get());
			m.addAttribute("realCreatorPassword", creatorPassword);
			return "creator/realUpdateMe";
		}
		return "creator/login";
	}

	@PostMapping("/updateAboutMe")
	public String updateAboutMe(@RequestParam String creatorName, @RequestParam String creatorEmail,
			@RequestParam String creatorPassword, @RequestParam String tel,
			@RequestParam MultipartFile profileImgPath, HttpSession session) throws IllegalStateException, IOException {
		CreatorEntity user = (CreatorEntity) session.getAttribute("creatorSession");
		creatorService.updateAboutMe(user.getCreatorId(), creatorName, creatorEmail, creatorPassword, tel, profileImgPath, session);
		session.invalidate();
		return "redirect:/";
	}

	@PostMapping("/deleteAccount")
	public String deleteAccount(@RequestParam long creatorId, HttpSession session) {
		log.info("deleteAccount 요청이 들어왔습니다. creatorId: {}", creatorId);
		creatorService.deleteCreatorAccount(creatorId);
		session.invalidate();
		return "index";
	}

	@PostMapping("/like")
	public String addLike(@RequestParam long likeVdoId, @RequestParam String likeVdoName, HttpSession session) {
		videosRepository.findById(likeVdoId).ifPresent(vdo -> {
			likeService.addLike(likeVdoId, likeVdoName, session);
		});
		return "redirect:/watch?v=" + videosRepository.findById(likeVdoId).orElse(null).getVideoUrl();
	}

	@PostMapping("/delLike")
	public String delLike(@RequestParam long likeId) {
		return likeService.delLike(likeId);
	}

}
