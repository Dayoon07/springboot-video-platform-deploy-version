package com.e.d.model.service;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;

import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.e.d.model.dto.LikeVideosDto;
import com.e.d.model.entity.CommentEntity;
import com.e.d.model.entity.CreatorEntity;
import com.e.d.model.entity.SubscriptionsEntity;
import com.e.d.model.entity.VideosEntity;
import com.e.d.model.mapper.VideosMapper;
import com.e.d.model.repository.CommentRepository;
import com.e.d.model.repository.CreatorRepository;
import com.e.d.model.repository.LikeRepository;
import com.e.d.model.repository.SubscriptionsRepository;
import com.e.d.model.repository.VideosRepository;
import com.e.d.model.vo.VideosVo;

import jakarta.servlet.http.HttpSession;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class VideosService {

	private final CreatorRepository creatorRepository;
	private final VideosRepository videosRepository;
	private final CommentRepository commentRepository;
	private final SubscriptionsRepository subscriptionsRepository;
	private final LikeRepository likeRepository;

	private final VideosMapper mapper;
	
	public void uploadVideo(String tag, String title, String more, String videoLen, MultipartFile imgPath,
			MultipartFile videoPath, HttpSession session) throws IOException {
		CreatorEntity creator = (CreatorEntity) session.getAttribute("creatorSession");
		Optional<CreatorEntity> user = creatorRepository.findByCreatorName(creator.getCreatorName());
		if (user.isEmpty() || user.get().getCreatorName() == null || user.get().getCreatorName().isEmpty()) {
			throw new IllegalArgumentException("크리에이터를 찾을 수가 없습니다");
		}

		String thumbnailDir = session.getServletContext().getRealPath("/resources/video-img/");
		String videoDir = session.getServletContext().getRealPath("/resources/video/");

		String n = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd-HH-mm-ss"));
		String imgExten = imgPath.getOriginalFilename().substring(imgPath.getOriginalFilename().lastIndexOf("."));
		String videoExten = videoPath.getOriginalFilename().substring(videoPath.getOriginalFilename().lastIndexOf("."));

		String imgName = n + UUID.randomUUID().toString().replaceAll("[^a-zA-Z0-9]", "") + imgExten;
		String videoName = n + UUID.randomUUID().toString().replaceAll("[^a-zA-Z0-9]", "") + videoExten;

		File imgDir = new File(thumbnailDir);
		File vdoDir = new File(videoDir);

		if (!imgDir.exists()) imgDir.mkdirs();
		if (!vdoDir.exists()) vdoDir.mkdirs();

		imgPath.transferTo(new File(thumbnailDir + imgName));
		videoPath.transferTo(new File(videoDir + videoName));

		VideosEntity video = VideosEntity.builder()
				.creator(user.get().getCreatorName())
				.creatorVal(user.get().getCreatorId())
				.title(title)
				.more(more)
				.videoName(videoName)
				.videoPath("/resources/video/" + videoName)
				.videoLen(videoLen)
				.imgName(imgName)
				.imgPath("/resources/video-img/" + imgName)
				.createAt(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH시 mm분")))
				.frontProfileImg(user.get().getProfileImgPath())
				.videoUrl(UUID.randomUUID().toString().replaceAll("-", "")).tag(tag).build();

		videosRepository.save(video);
	}

	public Map<String, Object> watchVideo(String v, HttpSession session) {
		Optional<VideosEntity> optionalVideo = videosRepository.findByVideoUrl(v);

		if (optionalVideo.isEmpty())
			throw new IllegalArgumentException("Video not found");

		VideosEntity video = optionalVideo.get();
		CreatorEntity user = (CreatorEntity) session.getAttribute("creatorSession");
		Optional<CreatorEntity> creator = creatorRepository.findById(video.getCreatorVal());

		List<CommentEntity> comments = commentRepository.findByCommentVideoOrderByCommentIdDesc(video.getVideoId());
		List<SubscriptionsEntity> subscriptions = subscriptionsRepository
				.findBySubscriberId(creator.get().getCreatorId());
		Map<String, Object> response = new HashMap<>();

		if (user != null) {
			video.setViews(video.getViews() + 1);
			video.setCommentCnt(comments.size());
			videosRepository.save(video);

			if (likeRepository.findByLikeVdoIdAndLikerId(video.getVideoId(), user.getCreatorId()).isPresent()) {
				response.put("likeuser", true);
				response.put("delLikeBtn", likeRepository
						.findByLikeVdoIdAndLikerId(video.getVideoId(), user.getCreatorId()).get().getLikeId());
			} else {
				response.put("likeuser", false);
			}
		}

		boolean isSubscribed = user != null && subscriptions.stream()
				.anyMatch(subscription -> subscription.getSubscribingId() == user.getCreatorId());

		response.put("watchTheVideo", video);
		response.put("videoCreatorProfileInfo", creator.orElse(null));
		response.put("recentVideo", videosRepository.findAll(Sort.by(Direction.DESC, "videoId")));
		response.put("watchTheVideoCommentList", comments);
		response.put("thisIsSubscribed", isSubscribed);
		response.put("likeCount", likeRepository.countByLikeVdoId(video.getVideoId()));

		return response;
	}

	public long sumByMyVideoViews(long creatorVal) {
		return mapper.sumByMyVideoViews(creatorVal);
	}

	public long sumByMyVideoLikes(long creatorVal) {
		return mapper.sumByMyVideoLikes(creatorVal);
	}

	public void updateLike(long likes, long videoId) {
		mapper.updateLike(likes, videoId);
	}

	public void updateVideo(Long videoId, String creatorName, String tag, String title, String more,
			MultipartFile imgPath, MultipartFile videoPath, String videoLen, String currentImgPath, 
			String currentVideoPath, HttpSession session) {
		System.out.println("videoId: " + videoId);
		System.out.println("creatorName: " + creatorName);
		System.out.println("tag: " + tag);
		System.out.println("title: " + title);
		System.out.println("more: " + more);
		System.out.println("videoLen: " + videoLen);
		System.out.println("currentImgPath: " + currentImgPath);
		System.out.println("currentVideoPath: " + currentVideoPath);

		VideosEntity video = videosRepository.findById(videoId).orElseThrow(() -> new IllegalArgumentException("존재하지 않는 비디오입니다."));
		creatorRepository.findByCreatorName(creatorName).orElseThrow(() -> new IllegalArgumentException("크리에이터를 찾을 수 없습니다."));

		video.setTitle(title);
		video.setMore(more);
		video.setTag(tag);
		video.setVideoLen(videoLen);

		try {
			String thumbnailDir = session.getServletContext().getRealPath("/resources/video-img/");
			String videoDir = session.getServletContext().getRealPath("/resources/video/");

			String n = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd-HH-mm-ss"));

			File imgDir = new File(thumbnailDir);
			File vdoDir = new File(videoDir);

			if (!imgDir.exists()) imgDir.mkdirs();
			if (!vdoDir.exists()) vdoDir.mkdirs();

			if (imgPath != null && !imgPath.isEmpty() && !currentImgPath.equals(imgPath.getOriginalFilename())) {
				String imgExten = imgPath.getOriginalFilename().substring(imgPath.getOriginalFilename().lastIndexOf("."));
				String imgName = n + UUID.randomUUID().toString() + imgExten;
				imgPath.transferTo(new File(thumbnailDir + imgName));
				video.setImgName(imgName);
				video.setImgPath("/resources/video-img/" + imgName);
			}
			if (videoPath != null && !videoPath.isEmpty()
					&& !currentVideoPath.equals(videoPath.getOriginalFilename())) {
				String videoExten = videoPath.getOriginalFilename().substring(videoPath.getOriginalFilename().lastIndexOf("."));
				String videoName = n + UUID.randomUUID().toString() + videoExten;
				videoPath.transferTo(new File(videoDir + videoName));
				video.setVideoName(videoName);
				video.setVideoPath("/resources/video/" + videoName);
			}

			videosRepository.save(video);

		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException("파일 처리 중 오류 발생", e);
		}
	}

	public List<VideosEntity> getCreatorVideos(Long creatorId) {
		return videosRepository.findByCreatorVal(creatorId);
	}
	
	public long addLikeButRestApi(long param, long id) {
		VideosEntity video = videosRepository.findById(id).orElse(null);
		video.setLikes(param);
		videosRepository.save(video);
		return video.getLikes();
	}
	
	public List<LikeVideosDto> selectByMyLikeVideo(long id) {
		return mapper.selectByMyLikeVideo(id);
	}
	
	public List<VideosVo> search(String searchWord) {
		return mapper.search(searchWord);
	}
	
	public List<VideosVo> allVideo() {
		return mapper.allVideo();
	}
	
	public List<VideosEntity> repositoryAllVideo() {
		return videosRepository.findAll();
	}
	
	@Transactional
	public void myVideoDelete(long videoId, HttpSession session) {
		CreatorEntity user = (CreatorEntity) session.getAttribute("creatorSession");
		if (user != null && videosRepository.findById(videoId).isPresent()) {
			commentRepository.deleteByCommentVideo(videoId);
			likeRepository.deleteBylikeVdoId(videoId);
			videosRepository.deleteById(videoId);
		}
	}
	
}
