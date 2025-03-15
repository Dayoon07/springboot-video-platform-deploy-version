package com.e.d.model.vo;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class LikeVo {
	private long likeId;
	private long likeVdoId;
	private String likeVdoName;
	private long likerId;
	private String likerName;
	private String datetime;
}
