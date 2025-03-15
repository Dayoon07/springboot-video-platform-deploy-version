package com.e.d.model.vo;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SubscriptionsVo {
	private long subscriptionId;
	private String subscriberName;
	private long subscriberId;
	private String subscribingName;
	private long subscribingId;
	private String subscribedAt;
}
