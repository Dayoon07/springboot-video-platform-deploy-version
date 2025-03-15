package com.e.d.model.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "WHYNOT_VIDEOS")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class VideosEntity {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "video_id", nullable = false)
	private long videoId;
	
	@Column(name = "creator", nullable = false)
	private String creator;
	
	@Column(name = "creator_val", nullable = false)
	private long creatorVal;
	
	@Column(name = "title", nullable = false)
	private String title;
	
	@Lob
	@Basic(fetch = FetchType.LAZY)
	@Column(name = "more")
	private String more;
	
	@Column(name = "video_name", nullable = false)
	private String videoName;
	
	@Column(name = "video_path", nullable = false)
	private String videoPath;
	
	@Column(name = "video_len", nullable = false)
	private String videoLen;
	
	@Column(name = "img_name", nullable = false)
	private String imgName;
	
	@Column(name = "img_path", nullable = false)
	private String imgPath;
	
	@Column(name = "create_at", nullable = false)
	private String createAt;
	
	@Column(name = "front_profile_img", nullable = false)
	private String frontProfileImg;
	
	@Column(name = "video_url", unique = true, nullable = false)
	private String videoUrl;
	
	@Column(name = "views")
	private long views;
	
	@Column(name = "likes")
	private long likes;
	
	@Column(name = "comment_cnt")
	private long commentCnt;
	
	@Column(name = "tag")
	private String tag;
	
	public void incrementVideoViews() {
		this.views++;
	}
	
}