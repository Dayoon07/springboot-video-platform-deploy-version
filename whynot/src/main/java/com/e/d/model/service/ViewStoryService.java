package com.e.d.model.service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.stereotype.Service;

import com.e.d.model.dto.ViewStoryVideosDto;
import com.e.d.model.entity.CreatorEntity;
import com.e.d.model.entity.ViewStoryEntity;
import com.e.d.model.mapper.ViewStoryMapper;
import com.e.d.model.repository.VideosRepository;
import com.e.d.model.repository.ViewStoryRepository;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class ViewStoryService {

	private final VideosRepository videosRepository;
	private final ViewStoryRepository repository;
	
	private final ViewStoryMapper mapper;
	
	public void viewStoryInsert(String videoUrl, HttpSession session) {
		CreatorEntity user = (CreatorEntity) session.getAttribute("creatorSession");
		videosRepository.findByVideoUrl(videoUrl).ifPresent(e -> {
			ViewStoryEntity entity = ViewStoryEntity.builder()
					.watchedVideoId(e.getVideoId())
					.viewUserId(user.getCreatorId())
					.datetime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")))
					.build();
			log.info("{}", entity);
			repository.save(entity);
		});
	}
	
	public List<ViewStoryVideosDto> myViewStorySelect(long id) {
		return mapper.myViewStorySelect(id);
	}
	
}
