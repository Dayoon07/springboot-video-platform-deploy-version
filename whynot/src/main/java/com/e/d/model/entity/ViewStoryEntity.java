package com.e.d.model.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "WHYNOT_VIEWSTORY")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ViewStoryEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "view_story_id", nullable = false)
	private long viewStoryId;
	
	@Column(name = "watched_video_id", nullable = false)
	private long watchedVideoId;
	
	@Column(name = "view_user_id", nullable = false)
	private long viewUserId;
	
	@Column(name = "datetime", nullable = false)
	private String datetime;
	
}
