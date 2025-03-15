package com.e.d.model.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.e.d.model.entity.LikeEntity;

@Repository
public interface LikeRepository extends JpaRepository<LikeEntity, Long> {
	Optional<LikeEntity> findByLikeVdoIdAndLikerId(long likeVdoId, long likerId);

	long countByLikeVdoId(long likeVdoId);
	
	List<LikeEntity> findByLikerId(Long likerId);
	
	void deleteByLikerId(long likerId);
	
	void deleteBylikeVdoId(long likeVdoId);
}
