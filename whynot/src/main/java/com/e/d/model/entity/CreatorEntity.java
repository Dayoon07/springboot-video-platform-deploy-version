package com.e.d.model.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "WHYNOT_CREATOR")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CreatorEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "creator_id", nullable = false)
	private long creatorId;

	@Column(name = "creator_name", nullable = false)
	private String creatorName;

	@Column(name = "creator_email", nullable = false)
	private String creatorEmail;

	@Column(name = "creator_password", nullable = false)
	private String creatorPassword;

	@Column(name = "create_at", nullable = false)
	private String createAt;

	@Lob
	@Basic(fetch = FetchType.LAZY)
	@Column(name = "bio")
	private String bio;

	@Column(name = "tel", nullable = false)
	private String tel;

	@Column(name = "profile_img")
	private String profileImg;

	@Column(name = "profile_img_path")
	private String profileImgPath;

	@Column(name = "subscribe")
	private long subscribe;

	public void updateProfile(String creatorName, String creatorEmail, String creatorPassword, String tel,
			String profileImgPath) {
		this.creatorName = creatorName;
		this.creatorEmail = creatorEmail;
		this.creatorPassword = creatorPassword;
		this.tel = tel;
		this.profileImgPath = profileImgPath;
	}

}
