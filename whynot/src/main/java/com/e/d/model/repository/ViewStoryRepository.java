package com.e.d.model.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.e.d.model.entity.ViewStoryEntity;

@Repository
public interface ViewStoryRepository extends JpaRepository<ViewStoryEntity, Long> {
	void deleteByViewUserId(long viewUserId);
}
