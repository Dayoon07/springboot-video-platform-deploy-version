package com.e.d.model.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "WHYNOT_SUBSCRIPTIONS")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SubscriptionsEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "subscription_id", nullable = false)
	private long subscriptionId;
	
	@Column(name = "subscriber_name", nullable = false)
	private String subscriberName;
	
	@Column(name = "subscriber_id", nullable = false)
	private long subscriberId;
	
	@Column(name = "subscribing_name", nullable = false)
	private String subscribingName;
	
	@Column(name = "subscribing_id", nullable = false)
	private long subscribingId;
	
	@Column(name = "subscribed_at", nullable = false)
	private String subscribedAt;
	
}
