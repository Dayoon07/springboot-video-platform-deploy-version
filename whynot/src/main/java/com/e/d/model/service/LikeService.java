package com.e.d.model.service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import org.springframework.stereotype.Service;

import com.e.d.model.entity.CreatorEntity;
import com.e.d.model.entity.LikeEntity;
import com.e.d.model.entity.VideosEntity;
import com.e.d.model.repository.LikeRepository;
import com.e.d.model.repository.VideosRepository;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class LikeService {

	private final LikeRepository likeRepository;
	private final VideosRepository videosRepository;
	
	public void addLike(long likeVdoId, String likeVdoName, HttpSession session) {
		CreatorEntity user = (CreatorEntity) session.getAttribute("creatorSession");
		
		String now = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd a HH:mm:ss"));
		
		LikeEntity entity = LikeEntity.builder()
				.likeVdoId(likeVdoId)
				.likeVdoName(likeVdoName)
				.likerId(user.getCreatorId())
				.likerName(user.getCreatorName())
				.datetime(now)
				.build();
		likeRepository.save(entity);
		log.info("{}이(가) {}영상에 좋아요를 눌렀습니다", user.getCreatorName(), likeVdoName);
	}
	
	public String delLike(long likeId) {
		LikeEntity like = likeRepository.findById(likeId).get();
		VideosEntity video = videosRepository.findById(like.getLikeVdoId()).get();
		likeRepository.deleteById(likeId);;
		log.info("{}영상에 대한 좋아요 하나가 취소 되었습니다", video.getTitle());
		return "redirect:/watch?v=" + video.getVideoUrl();
	}
	
}
