package com.e.d.model.vo;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ViewStoryVo {
	private long viewStoryId;
	private long watchedVideoId;
	private long viewUserId;
	private String datetime;
}
