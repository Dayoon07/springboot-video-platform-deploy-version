package com.e.d.model.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.e.d.model.entity.SubscriptionsEntity;

@Repository
public interface SubscriptionsRepository extends JpaRepository<SubscriptionsEntity, Long> {
	Optional<SubscriptionsEntity> findBySubscriberIdAndSubscribingId(long subscriberId, long subscribingId);

	List<SubscriptionsEntity> findBySubscriberId(long subscriberId);

	List<SubscriptionsEntity> findBySubscribingId(long subscribingId);

	long countBySubscriberId(long subscriberId);

	void deleteBySubscribingId(long subscribingId);
}
