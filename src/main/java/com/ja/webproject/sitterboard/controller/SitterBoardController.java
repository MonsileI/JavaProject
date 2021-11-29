package com.ja.webproject.sitterboard.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.ja.webproject.sitterboard.service.SitterBoardServiceImpl;
import com.ja.webproject.vo.HE_MemberVo;
import com.ja.webproject.vo.HE_SitterBoardVo;
import com.ja.webproject.vo.HE_SitterBoard_CommentVo;
import com.ja.webproject.vo.HE_SitterBoard_ImageBoardVo;

@Controller
@RequestMapping("/sitterboard/*")
public class SitterBoardController {
	
	@Autowired
	public SitterBoardServiceImpl sitterboardServiceImpl;
	
	@RequestMapping("HE_SitterBoardList.do")
	public String SitterBoardList(
			Model model, 
			String search_type, 
			String search_word,
			@RequestParam(defaultValue = "1") int page_number) {
		

		ArrayList<HashMap<String, Object>> contentList = sitterboardServiceImpl.getContents(search_type, search_word,
				page_number);
		
		
		int count = sitterboardServiceImpl.getContentCount(search_type, search_word, page_number); // 전체
																											// searching한
																											// 보드 갯수값

		
		int totalPageCount = (int) Math.ceil(count / 8.0); // 반올림 함수. 1.1이면 2가 나오면 되니까~! 전체글이 55개면 토탈카운트페이지는 55/10의
															// 반올림값

		int currentPage = page_number; // 지금 들어가있는 페이지

		int beginPage = ((currentPage - 1) / 5) * 5 + 1; // int값이니까 1 (int값은 실수인 .이하의 소수값인 경우 0이 됨;; 이걸 이용하다니..
		int endPage = ((currentPage - 1) / 5 + 1) * (5); // int값이니까 5

		if (endPage > totalPageCount) {

			endPage = totalPageCount; // 끝페이지 맞추기 위해서!

		}

		// 페이지 링크 만들어주는 메소드(정상적 검색, null값이 아닌 경우에 추가하는 메소드)
		String addParam = "";

		if (search_type != null && search_word != null) {
			addParam += "&search_type=" + search_type; // 이거 ""안에 띄어쓰기하면 인식 안된다잉 ㅇㅋ?
			addParam += "&search_word=" + search_word;
		}
		model.addAttribute("addParam", addParam);

		model.addAttribute("currentPage", currentPage);
		model.addAttribute("beginPage", beginPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("totalPageCount", totalPageCount);

		model.addAttribute("contentList", contentList); // request라고 생각하면 됨 (메인페이지로 포워딩)
		
		
		return "sitterboard/HE_SitterBoardList";
	}
	

	@RequestMapping("writeHE_SitterPage.do")
	public String writeHP_SitterPage(Model model) {

		return "sitterboard/writeHE_SitterPage";

	}

	@RequestMapping("writeHE_SitterProcess.do") // 이미지 보내주는 api(여러개 보낼수도 있으니 배열로)
	public String writeHE_SitterProcess(HE_SitterBoardVo param, MultipartFile[] board_files, HttpSession session) { // 여까진
																													// 멤버no가
		//System.out.println("controller");
		ArrayList<HE_SitterBoard_ImageBoardVo> boardImageVoList = 
				new ArrayList<HE_SitterBoard_ImageBoardVo>();

		// 파일 업로드

		for (MultipartFile boardFile : board_files) { // 물리적으로 문제가 발생할 수 있는 api는 내부에서 throws exception -> ex - file(하드
														// 고장날수도..),network(통신 고장날수도..)

			if (boardFile.isEmpty()) {

				continue; // break;는 탈출을 해버려서 위험해! (첫번째는 비어있고 두번째에 있을수도 있잖아..)
							// 책에서는 length 사용

			}
			System.out.println("안녕하세요!");
			String rootFolderName = "/Users/soos/Desktop/uploadFolder/";
			//String rootFolderName = "/uploadFolder/";

			// 랜덤한 파일명을 만들어보자!!!(시간 + 랜덤 활용)
			String originalFilename = boardFile.getOriginalFilename();
			// .jpg ( 확장자 뽑아냄! )
			String ext = originalFilename.substring(originalFilename.lastIndexOf(".")); // 뒤에서부터 점을 찾아야 하니까 lastIndexOf
																						// ...
			String uuidName = UUID.randomUUID().toString();
			long currentTimeMillis = System.currentTimeMillis();
			String randomFileName = uuidName + "_" + currentTimeMillis + ext;

			// 날짜별로 폴더를 만들어보자!(오늘 날짜 폴더!)
			Date today = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd"); // 날짜 -> 문자로 만들어주는 클래스(폴더가 년,월,일로 만들어지겠지? 슬러시 썼으니														// ㅋㅋ)
			String todayFolderName = sdf.format(today);
			String uploadFolderName = rootFolderName + todayFolderName;
			// 폴더 만드는 api
			File uploadFolder = new File(uploadFolderName); // 이 api는 파일의 속성들을 건드려줄 수 있는 아주 엄청난 아이지.

			if (!uploadFolder.exists()) {
				uploadFolder.mkdirs(); // make directory(보통 폴더를 directory로 표현) (여러개 동시에 생성시 mkdirs)-년도,월,일

			}
			// 최종 파일 경로+파일명은 saveFilePathName
			String saveFilePathName = uploadFolderName + "/" + randomFileName;
			// rootFolderName+오늘날짜 + / + uuidName + _ + 지금시간 + 확장자

			try {

				boardFile.transferTo(new File(saveFilePathName)); // 사용자가 업로드하는 파일명으로 업로드된다.(getOriginalFilename)
			} catch (Exception e) {
				e.printStackTrace();
			}

			// 데이터 처리
			HE_SitterBoard_ImageBoardVo boardImageVo = new HE_SitterBoard_ImageBoardVo();
			boardImageVo.setImageboard_ori(originalFilename); // imageVo에 ori세팅
			boardImageVo.setImageboard_url(todayFolderName + "/" + randomFileName); // imageVo에 url세팅

			boardImageVoList.add(boardImageVo); // 어레이 리스트에 저장(for문 )
			
		}

		// 아래 데이터 처리

		HE_MemberVo sessionUser = (HE_MemberVo) session.getAttribute("sessionUser");
		int member_no = sessionUser.getMember_no();// 그래서 세션을 불러온거임

		param.setMember_no(member_no); // 그래서 member_no를 불러온 parameter에 member_no에 세팅해주고 ㅇㅋ?

		sitterboardServiceImpl.writeContent(param, boardImageVoList); // 요건 파라미터를 서비스에 넘기는겨
		
		return "redirect:./HE_SitterBoardList.do"; // 글고 컨트롤러로 이동~(리턴)

	}

	@RequestMapping("readHE_SitterPage.do")
	public String readHE_SitterPage(int sitterboard_no, Model model, HttpSession session) {
		
		// 조회수 증가..
		System.out.println(session.getAttribute("sessionBoard"));

		if (session.getAttribute("sessionBoard") == null
				|| (int) session.getAttribute("sessionBoard") != sitterboard_no) {
			sitterboardServiceImpl.increaseReadCount(sitterboard_no);

			session.setAttribute("sessionBoard", sitterboard_no);
		}

		
		// 조회...
		HashMap<String, Object> map = sitterboardServiceImpl.getContent(sitterboard_no);

		model.addAttribute("content", map);

		// 댓글 관련...

		ArrayList<HashMap<String, Object>> comment =
				sitterboardServiceImpl.readComment(sitterboard_no);

		model.addAttribute("comment", comment);

		// 댓글 갯수...
		int commentCount = sitterboardServiceImpl.CommentCount(sitterboard_no);

		model.addAttribute("commentCount", commentCount);
		
		//System.out.println("comment;"+commentCount);

		HE_MemberVo sessionUser = (HE_MemberVo) session.getAttribute("sessionUser");
		session.setAttribute("board_no", sitterboard_no);

		return "sitterboard/readHE_SitterPage";

	}

	@RequestMapping("updateHE_SitterPage.do")
	public String updateHE_SitterPage(int sitterboard_no, Model model) { // 여기도 역시나 viewer로 출력값을 줘야 하니까 모델값

		HashMap<String, Object> map = sitterboardServiceImpl.getContent(sitterboard_no); // 저번에 만들어놓은 해쉬맵(BoardVo랑 MemberVo
																					// 묶어놓은거)
		model.addAttribute("content", map);

		return "sitterboard/updateHE_SitterPage";

	}

	@RequestMapping("updateHE_SitterBoardProcess.do")
	public String updateHE_SitterBoardProcess(HE_SitterBoardVo param) {

		sitterboardServiceImpl.updateContent(param);

		return "redirect:./readHE_SitterPage.do?sitterboard_no=" + param.getSitterboard_no();

	}

	@RequestMapping("deleteContentProcess.do")
	public String deleteContentProcess(int sitterboard_no) { // 파라미터가 날라오는 경우에는 무조건 받아야 됨

		sitterboardServiceImpl.deleteContent(sitterboard_no);

		return "redirect:./HE_SitterBoardList.do";
	}

	// 댓글쓰기

	@RequestMapping("writeCommentProcess.do")
	public String writeCommentProcess(HE_SitterBoard_CommentVo vo, HttpSession session) {


		HE_MemberVo sessionUser = (HE_MemberVo) session.getAttribute("sessionUser");

		int member_no = sessionUser.getMember_no();

		vo.setMember_no(member_no);

		sitterboardServiceImpl.writeComment(vo);

		return "redirect:./readHE_SitterPage.do?sitterboard_no=" + vo.getSitterboard_no();

	}

	// 댓글 삭제
	@RequestMapping("deleteCommentProcess.do")
	public String deleteCommentProcess(HE_SitterBoard_CommentVo vo) {

		sitterboardServiceImpl.deleteComment(vo);

		return "redirect:./readHE_SitterPage.do?sitterboard_no=" + vo.getSitterboard_no();

	}

	// 댓글 수정 페이지 매핑 
	@RequestMapping("updateHE_SitterBoardCommentPage.do")
	public String updateHE_SitterBoardCommentPage(int sitterboard_no , Model model) {

		HashMap<String, Object> map =  sitterboardServiceImpl.getContent(sitterboard_no); //저번에 만들어놓은 해쉬맵(BoardVo랑 MemberVo 묶어놓은거)
		
		model.addAttribute("content" , map);
		ArrayList<HashMap<String, Object>> comment = sitterboardServiceImpl.readComment(sitterboard_no);

		model.addAttribute("comment", comment);
		
		
		return "sitterboard/updateHE_SitterBoardCommentPage";
	}
	
	// 댓글 수정 프로세스 
	@RequestMapping("updateCommentProcess.do")
	public String updateCommentProcess(HE_SitterBoard_CommentVo vo) {
		
		sitterboardServiceImpl.updateComment(vo);
		
		return "redirect:./readHE_SitterPage.do?sitterboard_no="+ vo.getSitterboard_no();
	}

}
