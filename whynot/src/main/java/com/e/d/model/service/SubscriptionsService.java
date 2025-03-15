package com.e.d.model.service;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.e.d.model.entity.CreatorEntity;
import com.e.d.model.entity.SubscriptionsEntity;
import com.e.d.model.repository.CreatorRepository;
import com.e.d.model.repository.SubscriptionsRepository;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class SubscriptionsService {

	private final CreatorRepository creatorRepository;
	private final SubscriptionsRepository subscriptionsRepository;

	public String subscribe(long subscriberId, long subscribingId) {
		Optional<CreatorEntity> subscriberOpt = creatorRepository.findById(subscriberId);
		Optional<CreatorEntity> subscribingOpt = creatorRepository.findById(subscribingId);

		if (subscriberOpt.isEmpty() || subscribingOpt.isEmpty()) {
			throw new IllegalArgumentException("해당 사용자를 찾을 수 없습니다.");
		}

		CreatorEntity subscriber = subscriberOpt.get();
		CreatorEntity subscribing = subscribingOpt.get();

		// 구독 정보 저장
		SubscriptionsEntity subscription = SubscriptionsEntity.builder().subscriberName(subscriber.getCreatorName())
				.subscriberId(subscriberId).subscribingName(subscribing.getCreatorName()).subscribingId(subscribingId)
				.subscribedAt(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 a HH:mm:ss")))
				.build();
		subscriptionsRepository.save(subscription);

		// 구독자 수 업데이트
		long subscriberCount = subscriptionsRepository.countBySubscriberId(subscriberId);
		CreatorEntity updatedSubscriber = creatorRepository.findById(subscriberId).get();
		updatedSubscriber.setSubscribe(subscriberCount);
		creatorRepository.save(updatedSubscriber);

		log.info("{}님이 {}님을 구독했습니다.", subscribing.getCreatorName(), subscriber.getCreatorName());

		return "redirect:/channel/" + convertToUrlEncoded(subscriber.getCreatorName());
	}
	
	public String watchPageSubscribe(long subscriberId, long subscribingId, String videoUrl) {
		Optional<CreatorEntity> subscriberOpt = creatorRepository.findById(subscriberId);
		Optional<CreatorEntity> subscribingOpt = creatorRepository.findById(subscribingId);

		if (subscriberOpt.isEmpty() || subscribingOpt.isEmpty()) {
			throw new IllegalArgumentException("해당 사용자를 찾을 수 없습니다.");
		}

		CreatorEntity subscriber = subscriberOpt.get();
		CreatorEntity subscribing = subscribingOpt.get();

		// 구독 정보 저장
		SubscriptionsEntity subscription = SubscriptionsEntity.builder().subscriberName(subscriber.getCreatorName())
				.subscriberId(subscriberId).subscribingName(subscribing.getCreatorName()).subscribingId(subscribingId)
				.subscribedAt(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 a HH:mm:ss")))
				.build();
		subscriptionsRepository.save(subscription);

		// 구독자 수 업데이트
		long subscriberCount = subscriptionsRepository.countBySubscriberId(subscriberId);
		CreatorEntity updatedSubscriber = CreatorEntity.builder().creatorId(subscriberId)
				.creatorName(subscriber.getCreatorName()).creatorEmail(subscriber.getCreatorEmail())
				.creatorPassword(subscriber.getCreatorPassword()).createAt(subscriber.getCreateAt())
				.bio(subscriber.getBio()).tel(subscriber.getTel()).profileImg(subscriber.getProfileImg())
				.profileImgPath(subscriber.getProfileImgPath()).subscribe(subscriberCount).build();
		creatorRepository.save(updatedSubscriber);

		log.info("{}님이 {}님을 구독했습니다.", subscribing.getCreatorName(), subscriber.getCreatorName());

		return "redirect:/watch?v=" + videoUrl;
	}

	private String convertToUrlEncoded(String text) {
		try {
			return URLEncoder.encode(text, StandardCharsets.UTF_8.toString());
		} catch (Exception e) {
			log.error("URL 인코딩 중 오류 발생: {}", e.getMessage());
			return text;
		}
	}

	public boolean isSubscribed(Long creatorId, Long userId) {
		List<SubscriptionsEntity> list = subscriptionsRepository.findBySubscriberId(creatorId);
		return list.stream().anyMatch(subscription -> subscription.getSubscribingId() == userId);
	}

	public void unsubscribe(long subscriberId, HttpSession session) {
		CreatorEntity user = (CreatorEntity) session.getAttribute("creatorSession");
		Optional<SubscriptionsEntity> mySubscribe = subscriptionsRepository
				.findBySubscriberIdAndSubscribingId(subscriberId, user.getCreatorId());
		CreatorEntity channel = creatorRepository.findById(subscriberId).orElse(null);
		if (mySubscribe.isPresent()) {
			subscriptionsRepository.deleteById(mySubscribe.get().getSubscriptionId());
		}

		if (channel != null) {
			long subscriberCount = subscriptionsRepository.countBySubscriberId(subscriberId);
			channel.setSubscribe(subscriberCount);
			creatorRepository.save(channel);
		}
	}

	public List<CreatorEntity> mySubscribingChannelsList(HttpSession session) {
		CreatorEntity user = (CreatorEntity) session.getAttribute("creatorSession");
		// 나를 구독한 사람들의 정보 조회 (subscribingId 기준으로)
		List<SubscriptionsEntity> mySubscribers = subscriptionsRepository.findBySubscribingId(user.getCreatorId());

		// 나를 구독한 사람들의 creatorId 가져오기
		// subscriberId가 나를 구독한 채널들의 pk(creatorId)
		List<Long> subscriberIds = mySubscribers.stream().map(SubscriptionsEntity::getSubscriberId).collect(Collectors.toList());

		// 나를 구독한 사람들의 상세 정보 조회 (한 번에)
		List<CreatorEntity> subscribers = creatorRepository.findByCreatorIdIn(subscriberIds);
		return subscribers;
	}

	public List<CreatorEntity> myVideoSubscribe(HttpSession session) {
		CreatorEntity user = (CreatorEntity) session.getAttribute("creatorSession");
		
		// 내가 구독한 채널 정보 조회 (subscriberId 기준으로)
		List<SubscriptionsEntity> mySubscriptions = subscriptionsRepository.findBySubscriberId(user.getCreatorId());

		// 내가 구독한 채널들의 creatorId 가져오기
		List<Long> subscribedChannelIds = mySubscriptions.stream().map(SubscriptionsEntity::getSubscribingId)
				.collect(Collectors.toList());

		// 구독한 채널들의 상세 정보 조회 (한 번에)
		List<CreatorEntity> subscribedChannels = creatorRepository.findByCreatorIdIn(subscribedChannelIds);
		return subscribedChannels;
	}

}
