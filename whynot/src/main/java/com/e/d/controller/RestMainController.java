package com.e.d.controller;

import java.util.Collections;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.e.d.model.dto.CreatorSubscriptionDto;
import com.e.d.model.entity.CommentEntity;
import com.e.d.model.entity.CreatorEntity;
import com.e.d.model.entity.VideosEntity;
import com.e.d.model.repository.CommentRepository;
import com.e.d.model.service.CommentService;
import com.e.d.model.service.CreatorService;
import com.e.d.model.service.VideosService;
import com.e.d.model.vo.CommentVo;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@RestController
public class RestMainController {

	private final CommentRepository commentRepository; 
	private final CommentService commentService;
	private final CreatorService creatorService;
	private final VideosService videosService;
	
	@GetMapping("/api/all")
	public List<VideosEntity> list() {
		return videosService.repositoryAllVideo();
	}
	
	@GetMapping("/subscribeCount")
	public ResponseEntity<Long> subscribeCount(HttpSession s) {
	    CreatorEntity user = (CreatorEntity) s.getAttribute("creatorSession");
	    if (user == null) {
	        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(0L);
	    }
	    
	    return ResponseEntity.ok(creatorService.getSubscribeCount(user.getCreatorId()));
	}
	
	@GetMapping("/searchComments")
	public List<CommentVo> searchComments(HttpSession session, @RequestParam String keyword) {
	    CreatorEntity user = (CreatorEntity) session.getAttribute("creatorSession");
	    if (user == null) return Collections.emptyList();
	    
	    List<CommentVo> comments = commentService.findCommentsByKeyword(user.getCreatorId(), keyword);
	    return comments;
	}
	
	@GetMapping("/selectByMySubscribingUsername")
	public List<CreatorSubscriptionDto> selectByMySubscribingUsername(HttpSession session, @RequestParam String name) {
		CreatorEntity user = (CreatorEntity) session.getAttribute("creatorSession");
		if (user == null) {
			return Collections.emptyList();
		} else {
			return creatorService.selectBySubscribeUsername(name, user.getCreatorId());
		}
	}
	
	@PostMapping("/likeCount")
	public long likeCount(@RequestParam long param, @RequestParam long id) {
		log.info("서버가 받은 값 param: {}, id: {}", param, id);
		return videosService.addLikeButRestApi(param, id);
	}
	
	@PostMapping("/updateCommentFind")
	public CommentEntity updateCommentFind(@RequestBody Map<String, Long> request) {
	    long val = request.get("val");
	    return commentRepository.findByCommentId(val);
	}
	
	@PostMapping("/myInfo")
	public CreatorEntity userInfomation(@RequestParam long creatorId) {
		return creatorService.myInfo(creatorId);
	}
	
	@PostMapping("/api/findFullComment")
	public ResponseEntity<String> getFullComment(@RequestBody Map<String, Long> req) {
        return ResponseEntity.ok(commentService.getFullComment(req.get("commentId")));
    }
	
	@PostMapping("/createBio")
	public ResponseEntity<String> createBio(@RequestParam String bio, HttpSession session) {
		creatorService.createBio(bio, session);
		return ResponseEntity.ok(bio);
	}
	
	@PostMapping("/deleteButMyComment")
	public ResponseEntity<Long> deleteButMyComment(@RequestParam long commentId) {
		commentService.deleteComment(commentId);
		return ResponseEntity.ok(commentId);
	}
	
}
