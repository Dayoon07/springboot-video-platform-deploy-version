package com.e.d.model.vo;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class VideosVo {
	private long videoId;
	private String creator;
	private long creatorVal;
	private String title;
	private String more;
	private String videoName;
	private String videoPath;
	private String videoLen;
	private String imgName;
	private String imgPath;
	private String createAt;
	private String frontProfileImg;
	private String videoUrl;
	private long views;
	private long likes;
	private long unlikes;
	private long commentCnt;
	private String tag;
}