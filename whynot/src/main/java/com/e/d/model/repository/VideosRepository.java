package com.e.d.model.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.e.d.model.entity.VideosEntity;

@Repository
public interface VideosRepository extends JpaRepository<VideosEntity, Long> {
	List<VideosEntity> findByCreatorVal(long creatorVal);

	Optional<VideosEntity> findByVideoUrl(String videoUrl);

	/** JPA 검색 함수 (사용안함) */
	List<VideosEntity> searchByTitleIgnoreCaseContaining(String title);

	List<VideosEntity> findByTagContainingOrderByVideoIdDesc(String tag);

	void deleteByCreatorVal(long creatorVal);

	long countByCreatorVal(long creatorVal); // 총 업로드된 영상 개수

	List<VideosEntity> findByVideoIdAndTitle(long videoId, String title);
}
