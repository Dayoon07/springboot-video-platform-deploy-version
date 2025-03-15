package com.e.d.model.vo;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CreatorVo {
	private long creatorId;
	private String creatorName;
	private String creatorEmail;
	private String creatorPassword;
	private String createAt;
	private String bio;
	private String tel;
	private String profileImg;
	private String profileImgPath;
	private long subscribe;
}
