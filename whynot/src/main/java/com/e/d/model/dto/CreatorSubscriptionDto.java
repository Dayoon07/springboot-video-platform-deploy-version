package com.e.d.model.dto;

import com.e.d.model.vo.CreatorVo;
import com.e.d.model.vo.SubscriptionsVo;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CreatorSubscriptionDto {
    private CreatorVo creator;
    private SubscriptionsVo subscription;
}
