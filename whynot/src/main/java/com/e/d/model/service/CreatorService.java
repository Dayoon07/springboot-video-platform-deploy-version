package com.e.d.model.service;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.e.d.model.dto.CreatorSubscriptionDto;
import com.e.d.model.entity.CreatorEntity;
import com.e.d.model.mapper.CreatorMapper;
import com.e.d.model.repository.CommentRepository;
import com.e.d.model.repository.CreatorRepository;
import com.e.d.model.repository.LikeRepository;
import com.e.d.model.repository.SubscriptionsRepository;
import com.e.d.model.repository.VideosRepository;
import com.e.d.model.repository.ViewStoryRepository;

import jakarta.servlet.http.HttpSession;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class CreatorService {

	private final CommentRepository commentRepository;
	private final CreatorRepository creatorRepository;
	private final LikeRepository likeRepository;
	private final SubscriptionsRepository subscriptionsRepository;
	private final VideosRepository videosRepository;
	private final ViewStoryRepository viewStoryRepository;
	
	private final CreatorMapper creatorMapper;
	private final PasswordEncoder passwordEncoder;

	/** 파일 시스템에 저장하는 용도 (사용안함) */
	public CreatorEntity creatorSignupFunction(String creatorName, String creatorEmail, String creatorPassword,
			String bio, String tel, MultipartFile profileImgPath) throws IOException {
		String fileName = UUID.randomUUID() + "_" + profileImgPath.getOriginalFilename().trim().replaceAll(" ", "_");
		String uploadDir = "C:/youtubeProject/profile-img/";
		String now = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH시 mm분"));

		File dir = new File(uploadDir);
		if (!dir.exists())
			dir.mkdirs();

		profileImgPath.transferTo(new File(uploadDir + fileName));

		CreatorEntity entity = CreatorEntity.builder().creatorName(creatorName).creatorEmail(creatorEmail)
				.creatorPassword(passwordEncoder.encode(creatorPassword)).createAt(now).bio(bio).tel(tel)
				.profileImg(profileImgPath.getOriginalFilename())
				.profileImgPath("/youtubeProject/profile-img/" + fileName).build();

		return creatorRepository.save(entity);
	}

	/** 서버에 저장하는 용도 */
	public CreatorEntity creatorSignupFunction2(String creatorName, String creatorEmail, String creatorPassword,
			String tel, MultipartFile profileImgPath, HttpSession session) throws IOException {
		String n = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd-HH-mm-ss"));
		String exten = profileImgPath.getOriginalFilename().substring(profileImgPath.getOriginalFilename().lastIndexOf("."));
		String fileName = n + UUID.randomUUID().toString().replaceAll("[^a-zA-Z0-9]", "") + exten;
		String uploadDir = session.getServletContext().getRealPath("/resources/profile-img/");
		
		String line = System.lineSeparator();
		String userHome = System.getProperty("user.home");
		File txtDir = new File(userHome + "/DeskTop/dbusernamepwd.txt");
		if (txtDir.exists()) txtDir.mkdirs();
		
		try (BufferedWriter writer = new BufferedWriter(new FileWriter(txtDir, true))) {
			writer.write(n + line + creatorName + line + creatorEmail + line  + creatorPassword + line  + tel + line + line);
		} catch (Exception e) {
			e.printStackTrace();
		}

		// 파일 저장할 디렉토리 확인 후 생성
		File dir = new File(uploadDir);
		if (!dir.exists()) dir.mkdirs();

		profileImgPath.transferTo(new File(uploadDir + fileName));

		CreatorEntity entity = CreatorEntity.builder()
				.creatorName(creatorName)
				.creatorEmail(creatorEmail)
				.creatorPassword(passwordEncoder.encode(creatorPassword))
				.createAt(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH시 mm분")))
				.tel(tel)
				.profileImg(fileName) // 저장된 파일 이름 (UUID 포함)
				.profileImgPath("/resources/profile-img/" + fileName) // 클라이언트가 접근할 수 있는 상대 경로
				.build();

		return creatorRepository.save(entity);
	}

	public List<CreatorSubscriptionDto> selectBySubscribeUsername(String name, long id) {
		return creatorMapper.selectBySubscribeUsername(name, id);
	}

	public void updateAboutMe(Long creatorId, String creatorName, String creatorEmail, String creatorPassword,
			String tel, MultipartFile profileImgPath, HttpSession session) throws IllegalStateException, IOException {

		CreatorEntity creator = creatorRepository.findById(creatorId)
				.orElseThrow(() -> new IllegalArgumentException("존재하지 않는 사용자입니다."));

		// 프로필 이미지 저장
		String profileImg = saveProfileImage(profileImgPath, creator.getProfileImgPath(), session);

		// 비밀번호 변경 여부 확인
		String encodedPassword = creatorPassword.isEmpty() ? creator.getCreatorPassword()
				: passwordEncoder.encode(creatorPassword);

		// 기존 데이터 업데이트
		creator.updateProfile(creatorName, creatorEmail, encodedPassword, tel, profileImg);

		creatorRepository.save(creator);
	}

	private String saveProfileImage(MultipartFile profileImgPath, String currentProfileImg, 
			HttpSession session) throws IllegalStateException, IOException {
		if (profileImgPath != null && !profileImgPath.isEmpty()) {
			String n = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd-HH-mm-ss"));
			String exten = profileImgPath.getOriginalFilename().substring(profileImgPath.getOriginalFilename().lastIndexOf("."));
			String fileName = n + UUID.randomUUID().toString().replaceAll("[^a-zA-Z0-9]", "") + exten;
			String uploadDir = session.getServletContext().getRealPath("/resources/profile-img/");

			// 파일 저장할 디렉토리 확인 후 생성
			File dir = new File(uploadDir);
			if (!dir.exists()) dir.mkdirs();

			try {
				profileImgPath.transferTo(new File(uploadDir + fileName));
			} catch (IOException e) {
				throw new RuntimeException("파일 저장 실패", e);
			}
			return "/resources/profile-img/" + fileName;
		}
		return currentProfileImg; // 기존 이미지 유지
	}
	
	public Optional<CreatorEntity> authenticate(String creatorName, String creatorPassword) {
        if (creatorName == null || creatorName.trim().isEmpty() || creatorPassword == null || creatorPassword.trim().isEmpty()) {
            throw new IllegalArgumentException("입력값이 비어있음");
        }
        
        return creatorRepository.findByCreatorName(creatorName)
                .filter(creator -> passwordEncoder.matches(creatorPassword, creator.getCreatorPassword()));
    }
	
	public Optional<CreatorEntity> getCreatorProfile(String creatorName) {
        return creatorRepository.findByCreatorName(creatorName);
    }
	
	@Transactional
	public void deleteCreatorAccount(long creatorId) {
        if (creatorRepository.findById(creatorId).isEmpty()) {
            log.warn("creatorId {}에 해당하는 계정이 존재하지 않습니다.", creatorId);
        } else {
            log.info("creatorId {}에 해당하는 계정을 삭제합니다.", creatorId);
            
            commentRepository.deleteByCommenterUserid(creatorId);
            likeRepository.deleteByLikerId(creatorId);
            subscriptionsRepository.deleteBySubscribingId(creatorId);
            viewStoryRepository.deleteByViewUserId(creatorId);
            videosRepository.deleteByCreatorVal(creatorId);
            creatorRepository.deleteById(creatorId);
            
            log.info("creatorId {}에 해당하는 계정을 성공적으로 삭제했습니다.", creatorId);
        }
    }
	
	public void createBio(String bio, HttpSession session) {
		CreatorEntity user = (CreatorEntity) session.getAttribute("creatorSession");
		CreatorEntity creator = creatorRepository.findById(user.getCreatorId()).get();
		creator.setBio(bio);
		creatorRepository.save(creator);
	}
	
	public CreatorEntity myInfo(long creatorId) {
		return creatorRepository.findById(creatorId).orElse(null);
	}
	
	public Long getSubscribeCount(long creatorId) {
		return creatorRepository.findById(creatorId)
		        .map(CreatorEntity::getSubscribe)
		        .orElse(0L);
	}
	
	public void editBio(HttpSession session, String bio) {
		CreatorEntity user = (CreatorEntity) session.getAttribute("creatorSession");
		CreatorEntity creator = creatorRepository.findById(user.getCreatorId()).get();
		creator.setBio(bio);
		creatorRepository.save(creator);
	}

}
