package com.e.d.model.dto;

import com.e.d.model.vo.CommentVo;
import com.e.d.model.vo.VideosVo;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CommentVideosDto {
	private CommentVo commentVo;
	private VideosVo videosVo;
}
