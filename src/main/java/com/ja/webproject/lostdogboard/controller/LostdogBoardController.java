package com.ja.webproject.lostdogboard.controller;

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

import com.ja.webproject.finddogboard.service.FinddogBoardServiceImpl;
import com.ja.webproject.lostdogboard.service.LostdogBoardServiceImpl;
import com.ja.webproject.vo.HE_MemberVo;
import com.ja.webproject.vo.HE_Species_CategoryVo;
import com.ja.webproject.vo.HE_LostdogBoard_CommentVo;
import com.ja.webproject.vo.HE_LostDogBoardVo;
import com.ja.webproject.vo.HE_LostDogBoard_ImageBoardVo;

@Controller
@RequestMapping("/lostdogboard/*")
public class LostdogBoardController {
	
	@Autowired
	public LostdogBoardServiceImpl lostdogBoardServiceImpl;
	
	@Autowired
	public FinddogBoardServiceImpl finddogboardServiceImpl;
	
	
	@RequestMapping("lostdogList.do")
	public String lostdogList(
							Model model ,  
							String search_type, 
							String search_word, 
							@RequestParam(defaultValue = "1") int page_number)
							  //int는 참조타입이 아니라 null값이 안들어감(exception)
							 {													//나는 default를 4로 줬음 왜? 처음에 전체를 보고싶으니까!
		//할거 개많음..
		
		// 견종 선택 리스트(db에서 불러와서 목록에 뿌리기)
		ArrayList<HE_Species_CategoryVo> list = finddogboardServiceImpl.getSpeciesCategoryList();
		model.addAttribute("speciesCategoryList", list);
		
		
		ArrayList<HashMap<String, Object>> contentList = 
				lostdogBoardServiceImpl.getContents(search_type, search_word, page_number);
		
		int count = lostdogBoardServiceImpl.getContentCount(search_type, search_word, page_number); //전체 searching한 보드 갯수값
		
		int totalPageCount = (int) Math.ceil(count/10.0); //반올림 함수. 1.1이면 2가 나오면 되니까~! 전체글이 55개면 토탈카운트페이지는 55/10의 반올림값
		
		int currentPage = page_number; //지금 들어가있는 페이지
		
		int beginPage = ((currentPage-1)/5)*5 + 1;   //int값이니까 1 (int값은 실수인 .이하의 소수값인 경우 0이 됨;; 이걸 이용하다니..
		int endPage = ((currentPage-1)/5+1) *(5);    //int값이니까 5
		
		if(endPage > totalPageCount) {
			
			endPage = totalPageCount; //끝페이지 맞추기 위해서!
			
		}
		
		
		//페이지 링크 만들어주는 메소드(정상적 검색, null값이 아닌 경우에 추가하는 메소드)
		String addParam = "";
		
		if(search_type != null && search_word != null) {
			addParam += "&search_type=" + search_type;  //이거 ""안에 띄어쓰기하면 인식 안된다잉 ㅇㅋ?
			addParam += "&search_word=" + search_word;
		}
		model.addAttribute("addParam" , addParam);
		
		model.addAttribute("currentPage" , currentPage);
		model.addAttribute("beginPage", beginPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("totalPageCount", totalPageCount);
		
		model.addAttribute("contentList", contentList); //request라고 생각하면 됨 (메인페이지로 포워딩)

		
		return "lostdogboard/lostdogList";
		
		
	}
	
	
	@RequestMapping("writeHE_LostDogPage.do")
	public String writeHE_LostDogPage(Model model) {
		
		//System.out.println("매피매핑");
		// 견종 선택 리스트(db에서 불러와서 목록에 뿌리기)
		ArrayList<HE_Species_CategoryVo> list = finddogboardServiceImpl.getSpeciesCategoryList();
		model.addAttribute("speciesCategoryList", list);
		
		return "lostdogboard/writeHE_LostDogPage";
		
	}
	
	@RequestMapping("writeHE_LostDogProcess.do")
	public String writeHE_LostDogProcess(HE_LostDogBoardVo param, MultipartFile[] board_files ,HttpSession session) { //여까진 멤버no가 null값
		System.out.println("test:"+param.getLongtitude());
		//System.out.println("테스트" + param.getContact());
		//System.out.println("테스트" + param.getContent());
		//System.out.println("테스트" + param.getLostdogboard_no());
		//System.out.println("테스트" + param.getPetGender());
							
		ArrayList<HE_LostDogBoard_ImageBoardVo> boardImageVoList =
				new ArrayList<HE_LostDogBoard_ImageBoardVo>();
				//파일 업로드
				
		for(MultipartFile boardFile : board_files) { //물리적으로 문제가 발생할 수 있는 api는 내부에서 throws exception -> ex - file(하드 고장날수도..),network(통신 고장날수도..)
					
			if(boardFile.isEmpty()) {
						
				continue;  //break;는 탈출을 해버려서 위험해! (첫번째는 비어있고 두번째에 있을수도 있잖아..)
								   //책에서는 length 사용
			}
					
			String rootFolderName = "/Users/soos/Desktop/uploadFolder/";
			
			//랜덤한 파일명을 만들어보자!!!(시간 + 랜덤 활용)
			String originalFilename = boardFile.getOriginalFilename();
			//.jpg ( 확장자 뽑아냄! )
			String ext = originalFilename.substring(originalFilename.lastIndexOf(".")); //뒤에서부터 점을 찾아야 하니까 lastIndexOf ...
			String uuidName = UUID.randomUUID().toString();
			long currentTimeMillis = System.currentTimeMillis();
			String randomFileName = uuidName +"_" +  currentTimeMillis + ext;
			
			//날짜별로 폴더를 만들어보자!(오늘 날짜 폴더!)
			Date today = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd"); //날짜 -> 문자로 만들어주는 클래스(폴더가 년,월,일로 만들어지겠지? 슬러시 썼으니 ㅋㅋ)
			String todayFolderName = sdf.format(today);
			String uploadFolderName = rootFolderName + todayFolderName;
			//폴더 만드는 api
			File uploadFolder = new File(uploadFolderName); //이 api는 파일의 속성들을 건드려줄 수 있는 아주 엄청난 아이지.
			
			if(!uploadFolder.exists()) {
				uploadFolder.mkdirs(); //make directory(보통 폴더를 directory로 표현) (여러개 동시에 생성시 mkdirs)-년도,월,일
				
			}
			//최종 파일 경로+파일명은 saveFilePathName
			String saveFilePathName = uploadFolderName + "/" + randomFileName;
									//rootFolderName+오늘날짜 + / + uuidName + _ + 지금시간 + 확장자
			
			try {
					
				boardFile.transferTo(new File(saveFilePathName)); //사용자가 업로드하는 파일명으로 업로드된다.(getOriginalFilename)
			}catch (Exception e) {
				e.printStackTrace();
			}
			
			//데이터 처리
			HE_LostDogBoard_ImageBoardVo boardImageVo = new HE_LostDogBoard_ImageBoardVo();
			boardImageVo.setImageboard_ori(originalFilename);      //imageVo에 ori세팅
			boardImageVo.setImageboard_url(todayFolderName + "/" + randomFileName); //imageVo에 url세팅
			
			 boardImageVoList.add(boardImageVo); //어레이 리스트에 저장(for문 )	
			
		}

		//아래 데이터 처리
		
		
		HE_MemberVo sessionUser = (HE_MemberVo)session.getAttribute("sessionUser");
		
		int member_no = sessionUser.getMember_no();//그래서 세션을 불러온거임
		 
		param.setMember_no(member_no); //그래서 member_no를 불러온 parameter에 member_no에 세팅해주고 ㅇㅋ?
		
		lostdogBoardServiceImpl.writeContent(param, boardImageVoList); //요건 파라미터를 서비스에 넘기는겨
		
		
		//-=========================================================================================
		//=========================LostdogBoard & FinddogBoard matching system
		//아래 매칭결과 공지 프로세스 - 조건(견종과 날짜)으로 데이터 뽑기
		//int species_no = param.getSpecies_no();
		//Date lostDate = param.getLostDate();
	
		//boardServiceImpl.getMatchingDog(species_no, lostDate);
		if(finddogboardServiceImpl.getContentCount(null, null, 1) != 0) {			
			lostdogBoardServiceImpl.getMatchingDog(param, member_no);
		}
		
		return "redirect:./lostdogList.do"; //글고 컨트롤러로 이동~(리턴)
		
	}
	
	@RequestMapping("readHE_LostDogPage.do")
	public String readHE_LostDogPage(int lostdogboard_no, Model model, HttpSession session) { //vo로 받기엔 좀 부담스럽.. 어차피 넘버값이니까 글고 여기서 model은 api라고 생각 ㄱㄱ
		
		//조회수 증가..
		System.out.println(session.getAttribute("sessionBoard"));
			
		if(session.getAttribute("sessionBoard") == null || (int)session.getAttribute("sessionBoard") != lostdogboard_no) {
			lostdogBoardServiceImpl.increaseReadCount(lostdogboard_no);
			
			session.setAttribute("sessionBoard", lostdogboard_no);
		}

	
		//견종 선택 리스트(db에서 불러와서 목록에 뿌리기)
		ArrayList<HE_Species_CategoryVo> list = finddogboardServiceImpl.getSpeciesCategoryList();
		model.addAttribute("speciesCategoryList", list);

		//조회...
		HashMap<String, Object> map = lostdogBoardServiceImpl.getContent(lostdogboard_no);
		
		model.addAttribute("content", map);
	
		
		
		return "lostdogboard/readHE_LostDogPage";
		
	}
	
	@RequestMapping("updateHE_LostDogPage.do")
	public String updateHE_LostDogPage(int lostdogboard_no , Model model) { //여기도 역시나 viewer로 출력값을 줘야 하니까 모델값
		
		HashMap<String, Object> map =  lostdogBoardServiceImpl.getContent(lostdogboard_no); //저번에 만들어놓은 해쉬맵(BoardVo랑 MemberVo 묶어놓은거)
		
		model.addAttribute("content" , map);
		
		return "lostdogboard/updateHE_LostDogPage";
		
		
	}
	
	
	@RequestMapping("updateHE_LostDogBoardProcess.do")
	public String updateHE_LostDogBoardProcess(HE_LostDogBoardVo param) {
		
		lostdogBoardServiceImpl.updateContent(param);
		
		return "redirect:./readHE_LostDogPage.do?lostdogboard_no=" + param.getLostdogboard_no(); 
		
		
	}
	
	@RequestMapping("deleteContentProcess.do")
	public String deleteContentProcess(int lostdogboard_no) { //파라미터가 날라오는 경우에는 무조건 받아야 됨
		
		lostdogBoardServiceImpl.deleteContent(lostdogboard_no);
		
		return "redirect:./lostdogList.do";
	}
	/*
	///==================================취소 버튼 기능 없애기로!!!=================================================
	//==================권한 있는 자가 취소 버튼 눌렀을 떄, status='N'로 변경 
	@RequestMapping("cancelLostdog.do")
	public String cancelLostdog(int lostdogboard_no) {
		
		boardServiceImpl.cancelLostdog(lostdogboard_no);
		
		return "redirect:./readHE_LostdogPage.do?lostdogboard_no=" + lostdogboard_no;
	}
	*/
	
	

	
}
