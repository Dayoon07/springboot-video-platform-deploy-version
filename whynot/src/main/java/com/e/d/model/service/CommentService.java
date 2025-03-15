package com.e.d.model.service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.e.d.model.dto.CommentVideosDto;
import com.e.d.model.entity.CommentEntity;
import com.e.d.model.entity.CreatorEntity;
import com.e.d.model.entity.VideosEntity;
import com.e.d.model.mapper.CommentMapper;
import com.e.d.model.repository.CommentRepository;
import com.e.d.model.repository.CreatorRepository;
import com.e.d.model.repository.VideosRepository;
import com.e.d.model.vo.CommentVo;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class CommentService {

	private final CommentRepository commentRepository;
	private final CreatorRepository creatorRepository;
	private final VideosRepository videosRepository;
	
	private final CommentMapper commentMapper;
	
	public List<CommentVo> findCommentsByKeyword(long myid, String keyword) {
		return commentMapper.findCommentsByKeyword(myid, keyword);
	}
	
	public void commentAdd(long commentVideo, HttpSession session, String commentContent) {
		CreatorEntity user = (CreatorEntity) session.getAttribute("creatorSession");
		VideosEntity video = videosRepository.findById(commentVideo)
				.orElseThrow(() -> new IllegalArgumentException("videoId가 비어있습니다"));

		CreatorEntity creator = creatorRepository.findById(user.getCreatorId()).orElse(null);
		Optional<CreatorEntity> uploder = creatorRepository.findById(video.getCreatorVal());

		if (creator != null) {
			CommentEntity comment = CommentEntity.builder()
					.commentVideo(commentVideo)
					.commentUserid(uploder.get().getCreatorId())
					.commenter(creator.getCreatorName()).commentUserid(uploder.get().getCreatorId())
					.commenterUserid(user.getCreatorId())
					.commenterProfile(creator.getProfileImg())
					.commenterProfilepath(creator.getProfileImgPath())
					.commentContent(commentContent)
					.datetime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"))).build();
			commentRepository.save(comment);
		}
	}
	
	public String commentEdit(long commentId, String commentContent, long commentVideo) {
	 	CommentEntity comment = commentRepository.findById(commentId).orElseThrow(() -> new IllegalArgumentException("고유 아이디가 없습니다."));
	 	comment.setCommentContent(commentContent);
		commentRepository.save(comment);
		return "redirect:/watch?v=" + videosRepository.findById(commentVideo).orElse(null).getVideoUrl();
	}
	
	public List<CommentVideosDto> findMyAllComment(long commentId) {
		return commentMapper.findMyAllComment(commentId);
	}
	
	public void deleteComment(long commentId) {
		commentRepository.deleteById(commentId);
	}
	
	public void deleteCommentButAdminAccount(long commentId) {
		commentRepository.deleteById(commentId);
	}
	
	public String getFullComment(long commentId) {
		return commentRepository.findById(commentId)
				.orElse(null).getCommentContent();
    }
	
	public List<CommentVideosDto> selectByMyAllVideoCommentList(long id) {
		return commentMapper.selectByMyAllVideoCommentList(id);
	}
	
}
