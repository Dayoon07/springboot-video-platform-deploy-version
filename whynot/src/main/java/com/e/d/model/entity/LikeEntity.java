package com.e.d.model.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "WHYNOT_LIKE")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class LikeEntity {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "like_id", nullable = false)
	private long likeId;
	
	@Column(name = "like_vdo_id", nullable = false)
	private long likeVdoId;
	
	@Column(name = "like_vdo_name", nullable = false)
	private String likeVdoName;
	
	@Column(name = "liker_id", nullable = false)
	private long likerId;
	
	@Column(name = "liker_name", nullable = false)
	private String likerName;
	
	@Column(name = "datetime", nullable = false)
	private String datetime;
	
}
