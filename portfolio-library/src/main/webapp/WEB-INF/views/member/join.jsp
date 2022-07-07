<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입 - 규비개발자 도서관</title>
    <link rel="icon" href="/img/main/digital-library.png" type="image/x-icon">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
        integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="/css/member/join.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/sideMenu.jsp" />
    <div class="library-bg">
        <jsp:include page="/WEB-INF/views/include/menu.jsp" />
        <div class="library-main-bg">
            <div class="library-main-wrap">
                <div class="main-top-wrap">
                    <div class="d-flex top-box">
                    	 <a href="/">
	                        <svg xmlns="http://www.w3.org/2000/svg" width="15" height="15" fill="currentColor" class="bi bi-house-door" viewBox="0 0 16 16">
	                            <path d="M8.354 1.146a.5.5 0 0 0-.708 0l-6 6A.5.5 0 0 0 1.5 7.5v7a.5.5 0 0 0 .5.5h4.5a.5.5 0 0 0 .5-.5v-4h2v4a.5.5 0 0 0 .5.5H14a.5.5 0 0 0 .5-.5v-7a.5.5 0 0 0-.146-.354L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293L8.354 1.146zM2.5 14V7.707l5.5-5.5 5.5 5.5V14H10v-4a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5v4H2.5z"/>
	                        </svg>
                        </a>
                        <i class="fa-solid fa-angle-right"></i>
                        <a href="/member/join"><span>회원가입</span></a>
                    </div>
                </div>
                <div class="main-contents-wrap">
                    <div class="contents-box">
                        <div class="contents-title">
                            <h1>회원가입</h1>
                            <p>개인정보수집을 위해 반드시 이용 약관에 모두 동의해 주시기 바랍니다.</p>
                        </div>    
                        <div class="contents-main">
                            <article class="agreement">
                                <div class="title">이용약관 (필수)</div>
                                <div class="text">
                                    <p>
                                        <strong>제 1 장 총 칙</strong><br> &nbsp;<br> &nbsp;<br>
                                        <strong>제 1 조 목적</strong><br> &nbsp;<br> 본 약관은 서비스 이용자가
                                        귺빈개발자 도서관(이하 “회사”라 합니다)이 제공하는 온라인상의 인터넷 서비스(이하 “서비스”라고 하며, 접속 가능한
                                        유∙무선 단말기의 종류와는 상관없이 이용 가능한 “회사”가 제공하는 모든 “서비스”를 의미합니다. 이하 같습니다)에
                                        회원으로 가입하고 이를 이용함에 있어 회사와 회원(본 약관에 동의하고 회원등록을 완료한 서비스 이용자를 말합니다. 이하
                                        “회원”이라고 합니다)의 권리, 의무 및 책임사항을 규정함을 목적으로 합니다.<br> &nbsp;<br>
                                        &nbsp;<br> <strong>제 2 조 (약관의 명시, 효력 및 개정)</strong><br>
                                        &nbsp;<br> ① 회사는 이 약관의 내용을 회원이 쉽게 알 수 있도록 서비스 초기 화면에 게시합니다.<br>
                                        &nbsp;<br> ② 회사는 온라인 디지털콘텐츠산업 발전법, 전자상거래 등에서의 소비자보호에 관한 법률,
                                        약관의 규제에 관한 법률, 소비자기본법 등 관련법을 위배하지 않는 범위에서 이 약관을 개정할 수 있습니다.<br>
                                        &nbsp;<br> ③ 회사가 약관을 개정할 경우에는 기존약관과 개정약관 및 개정약관의 적용일자와 개정사유를
                                        명시하여 현행약관과 함께 그 적용일자 일십오(15)일 전부터 적용일 이후 상당한 기간 동안, 개정 내용이 회원에게
                                        불리한 경우에는 그 적용일자 삼십(30)일 전부터 적용일 이후 상당한 기간 동안 각각 이를 서비스 홈페이지에 공지하여
                                        고지합니다.<br> &nbsp;<br> ④ 회사가 전항에 따라 회원에게 통지하면서 공지∙고지일로부터
                                        개정약관 시행일 7일 후까지 거부의사를 표시하지 아니하면 승인한 것으로 본다는 뜻을 명확하게 고지하였음에도 의사표시가
                                        없는 경우에는 변경된 약관을 승인한 것으로 봅니다. 회원이 개정약관에 동의하지 않을 경우 회원은 제15조 제1항의
                                        규정에 따라 이용계약을 해지할 수 있습니다.<br> &nbsp;<br> &nbsp;<br>
                                        &nbsp;<br> <strong>제 2 장 회원의 가입 및 관리</strong><br> &nbsp;<br>
                                        &nbsp;<br> <strong>제 3 조 (회원가입절차)</strong><br> &nbsp;<br>
                                        ① 서비스 이용자가 본 약관을 읽고 “동의” 버튼을 누르거나 “확인” 등에 체크하는 방법을 취한 경우 본 약관에 동의한
                                        것으로 간주합니다.<br> &nbsp;<br> ② 회사의 서비스 이용을 위한 회원가입은 서비스
                                        이용자가 제1항과 같이 동의한 후, 회사가 정한 온라인 회원가입 신청서에 회원 ID를 포함한 필수사항을 입력하고,
                                        “등록하기” 내지 “확인” 단추를 누르는 방법으로 합니다. 다만, 회사가 필요하다고 인정하는 경우 회원에게 별도의
                                        서류를 제출하도록 할 수 있습니다.<br> &nbsp;<br> &nbsp;<br> <strong>제
                                            4 조 (회원등록의 성립과 유보 및 거절)</strong><br> &nbsp;<br> ① 회원등록은 제3조에 정한
                                        절차에 의한 서비스 이용자의 회원가입 신청과 회사의 회원등록 승낙에 의하여 성립합니다. 회사는 회원가입 신청자가
                                        필수사항 등을 성실히 입력하여 가입신청을 완료하였을 때에는 필요한 사항을 확인한 후 지체 없이 이를 승낙을 하여야
                                        합니다. 단 회원가입 신청서 제출 이외에 별도의 자료 제출이 요구되는 경우에는 예외로 합니다.<br>
                                        &nbsp;<br> ② 회사는 아래 각 호의 1에 해당하는 경우에는 회원등록의 승낙을 유보할 수 있습니다.<br>
                                        &nbsp;&nbsp; 1. 제공서비스 설비용량에 현실적인 여유가 없는 경우<br> &nbsp;&nbsp;
                                        2. 서비스를 제공하기에는 기술적으로 문제가 있다고 판단되는 경우<br> &nbsp;&nbsp; 3. 기타
                                        회사가 재정적, 기술적으로 필요하다고 인정하는 경우<br> &nbsp;<br> ③ 회사는 아래 각
                                        호의 1에 해당하는 경우에는 회원등록을 거절 할 수 있습니다.<br> &nbsp;&nbsp; 1. 가입신청서의
                                        내용을 허위로 기재하였거나 허위서류를 첨부하여 가입신청을 하는 경우<br> &nbsp;&nbsp; 2. 14세
                                        미만의 아동이 개인정보제공에 대한 동의를 부모 등 법정대리인으로부터 받지 않은 경우<br>
                                        &nbsp;&nbsp; 3. 기타 회사가 관련법령 등을 기준으로 하여 명백하게 사회질서 및 미풍양속에 반할 우려가
                                        있음을 인정하는 경우<br> &nbsp;&nbsp; 4. 제15조 제2항에 의하여 회사가 계약을 해지했던
                                        회원이 다시 회원 신청을 하는 경우<br> &nbsp;<br> &nbsp;<br> <strong>제
                                            5 조 (회원 ID 등의 관리책임)</strong><br> &nbsp;<br> ① 회원은 서비스 이용을 위한 회원
                                        ID, 비밀번호의 관리에 대한 책임, 본인 ID의 제3자에 의한 부정사용 등 회원의 고의∙과실로 인해 발생하는 모든
                                        불이익에 대한 책임을 부담합니다.<br> &nbsp;<br> ② 회원은 회원 ID, 비밀번호 및
                                        추가정보 등을 도난 당하거나 제3자가 사용하고 있음을 인지한 경우에는 즉시 본인의 비밀번호를 수정하는 등의 조치를
                                        취하여야 하며 즉시 이를 회사에 통보하여 회사의 안내를 따라야 합니다.<br> &nbsp;<br>
                                        &nbsp;<br> <strong>제 6 조 (개인정보의 수집 등)</strong><br>
                                        &nbsp;<br> 회사는 서비스를 제공하기 위하여 관련 법령의 규정에 따라 회원으로부터 필요한 개인정보를
                                        수집합니다.<br> &nbsp;<br> &nbsp;<br> <strong>제
                                            7 조 (회원정보의 변경)</strong><br> &nbsp;<br> 회원은 아래 각 호의 1에 해당하는 사항이
                                        변경되었을 경우 즉시 회원정보 관리페이지에서 이를 변경하여야 합니다. 이 경우 회사는 회원이 회원정보를 변경하지
                                        아니하여 발생한 손해에 대하여 책임을 부담하지 아니합니다.<br> &nbsp;<br>
                                        &nbsp;&nbsp; 1. 이메일 주소<br> &nbsp;<br> &nbsp;<br>
                                        &nbsp;<br> <strong>제 3 장 서비스의 이용</strong><br> &nbsp;<br>
                                        &nbsp;<br> <strong>제 8 조 (서비스 이용)</strong><br> &nbsp;<br>
                                        ① 서비스 이용은 회사의 서비스 사용승낙 직후부터 가능합니다.<br> &nbsp;<br> ② 서비스
                                        이용시간은 회사의 업무상 또는 기술상 불가능한 경우를 제외하고는 연중무휴 1일 24시간(00:00-24:00)으로 함을
                                        원칙으로 합니다. 다만, 서비스설비의 정기점검 등의 사유로 회사가 서비스를 특정범위로 분할하여 별도로 날짜와 시간을
                                        정할 수 있습니다.<br> &nbsp;<br> &nbsp;<br> <strong>제
                                            9 조 (서비스내용변경 통지 등)</strong><br> &nbsp;<br> 회사가 서비스 제공을 위해 계약한
                                        CP(Contents Provider)와의 계약종료, CP의 변경, 신규서비스의 개시 등의 사유로 서비스 내용이
                                        변경되거나 서비스가 종료되는 경우 회사는 공지를 통하여 서비스 내용의 변경 사항 또는 종료를 통지할 수 있습니다.<br>
                                        &nbsp;<br> &nbsp;<br> <strong>제 10 조 (권리의 귀속 및
                                            저작물의 이용)</strong><br> &nbsp;<br> ① 회원이 서비스 내에 게시한 게시물 등(이하 "게시물
                                        등"이라 합니다)의 저작권은 해당 게시물의 저작자에게 귀속됩니다.<br> &nbsp;<br> ②
                                        게시물 등은 회사가 운영하는 인터넷 사이트 및 모바일 어플리케이션을 통해 노출될 수 있으며, 검색결과 내지 관련
                                        프로모션 등에도 노출될 수 있습니다. 해당 노출을 위해 필요한 범위 내에서는 일부 수정, 복제, 편집되어 게시될 수
                                        있습니다. 이 경우, 회사는 저작권법 규정을 준수하며, 회원은 언제든지 고객센터 또는 각 서비스 내 관리기능을 통해
                                        해당 게시물 등에 대해 삭제 등의 조치를 취할 수 있습니다.<br> &nbsp;<br> &nbsp;<br>
                                        <strong>제 11 조 (서비스 이용의 제한 및 중지)</strong><br> &nbsp;<br>
                                        ① 회사는 아래 각 호의 1에 해당하는 사유가 발생한 경우에는 회원의 서비스 이용을 제한하거나 중지시킬 수 있습니다.<br>
                                        &nbsp;&nbsp; 1. 회원이 회사 서비스의 운영을 고의∙과실로 방해하는 경우<br>
                                        &nbsp;&nbsp; 2. 회원이 제13조의 의무를 위반한 경우<br> &nbsp;&nbsp; 3. 서비스용
                                        설비 점검, 보수 또는 공사로 인하여 부득이한 경우<br> &nbsp;&nbsp; 4. 전기통신사업법에 규정된
                                        기간통신사업자가 전기통신 서비스를 중지했을 경우<br> &nbsp;&nbsp; 5. 국가비상사태, 서비스
                                        설비의 장애 또는 서비스 이용의 폭주 등으로 서비스 이용에 지장이 있는 때<br> &nbsp;&nbsp; 6.
                                        기타 중대한 사유로 인하여 회사가 서비스 제공을 지속하는 것이 부적당하다고 인정하는 경우<br> &nbsp;<br>
                                        ② 회사는 전항의 규정에 의하여 서비스의 이용을 제한하거나 중지한 때에는 그 사유 및 제한기간등을 회원에게 알려야
                                        합니다.<br> &nbsp;<br> ③ 제15조 제2항에 의해 회사가 회원과의 계약을 해지하고 서비스
                                        이용을 중지시키기로 결정한 경우 회사는 회원의 서비스 이용을 중지시키고 재가입을 차단하기 위해 본인인증값을 저장합니다.<br>
                                        &nbsp;<br> ④ 정보통신망 이용촉진 및 정보보호 등에 관한 법률(이하 “정보통신망법”이라 합니다)의
                                        규정에 의해 다른 회원의 공개된 게시물 등이 본인의 사생활을 침해하거나 명예를 훼손하는 등 권리를 침해 받은 회원 또는
                                        제3자(이하 “삭제 등 신청인”이라 합니다)는 그 침해사실을 소명하여 회사에 해당 게시물 등의 삭제 또는 반박 내용의
                                        게재를 요청할 수 있습니다. 이 경우 회사는 해당 게시물 등의 권리 침해 여부를 판단할 수 없거나 당사자 간의 다툼이
                                        예상되는 경우 해당 게시물 등에 대한 접근을 임시적으로 차단하는 조치(이하 “임시삭제”라 합니다)를 최장 30일까지
                                        취합니다.<br> &nbsp;<br> ⑤ 제4항에 의해 본인의 게시물 등이 임시삭제된 회원(이하
                                        “게시자”라 합니다)은 임시삭제기간 중 회사에 해당 게시물 등을 복원해 줄 것을 요청(이하 “재게시 청구”라 합니다)할
                                        수 있으며, 회사는 임시삭제된 게시물의 명예훼손 등 판단에 대한 방송통신심의위원회 심의 요청에 대한 게시자 및 삭제 등
                                        신청인의 동의가 있는 경우 게시자 및 삭제 등 신청인을 대리하여 이를 요청하고 동의가 없는 경우 회사가 이를 판단하여
                                        게시물 등의 복원 여부를 결정합니다. 게시자의 재게시 청구가 있는 경우 임시삭제 기간 내에 방송통신심의위원회 또는
                                        회사의 결정이 있으면 그 결정에 따르고 그 결정이 임시삭제 기간 내에 있지 않는 경우 해당 게시물 등은 임시삭제 만료일
                                        이후 복원됩니다. 재게시 청구가 없는 경우 해당 게시물 등은 임시삭제 기간 만료 이후 영구 삭제 될 수 있습니다.<br>
                                        &nbsp;<br> ⑥ 회사는 서비스 내에 게시된 게시물 등이 사생활 침해 또는 명예훼손 등 제3자의 권리를
                                        침해한다고 인정하는 경우 제4항에 따른 회원 또는 제3자의 신고가 없는 경우에도 임시삭제(이하 “임의의 임시삭제”라
                                        합니다)를 취할 수 있습니다. 임의의 임시삭제된 게시물의 처리 절차는 제4항 후단 및 제5항의 규정에 따릅니다.<br>
                                        &nbsp;<br> ⑦ 회원의 게시물 등으로 인한 법률상 이익 침해를 근거로, 다른 회원 또는 제3자가 회원
                                        또는 회사를 대상으로 하여 민형사상의 법적 조치(예: 형사고소, 가처분 신청∙손해배상청구 등 민사소송의 제기)를 취하는
                                        경우, 회사는 동 법적 조치의 결과인 법원의 확정판결이 있을 때까지 관련 게시물 등에 대한 접근을 잠정적으로 제한할 수
                                        있습니다. 게시물 등의 접근 제한과 관련한 법적 조치의 소명, 법원의 확정 판결에 대한 소명 책임은 게시물 등에 대한
                                        조치를 요청하는 자가 부담합니다.<br> &nbsp;<br> &nbsp;<br> <strong>제
                                            12 조 (회사의 의무)</strong><br> &nbsp;<br> ① 회사는 회사의 서비스 제공 및 보안과 관련된
                                        설비를 지속적이고 안정적인 서비스 제공에 적합하도록 유지, 점검 또는 복구 등의 조치를 성실히 이행하여야 합니다.<br>
                                        &nbsp;<br> ② 회사는 회원이 수신 동의를 하지 않은 영리 목적의 광고성 전자우편, SMS 문자메시지
                                        등을 발송하지 아니합니다.<br> &nbsp;<br> ③ 회사는 서비스의 제공과 관련하여 알게 된
                                        회원의 개인정보를 본인의 승낙 없이 제3자에게 누설, 배포하지 않고, 이를 보호하기 위하여 노력합니다. 회원의
                                        개인정보보호에 관한 기타의 사항은 정보통신망법 및 회사가 별도로 정한 “개인정보관리지침”에 따릅니다.<br>
                                        &nbsp;<br> ④ 회사가 제3자와의 서비스 제공계약 등을 체결하여 회원에게 서비스를 제공하는 경우 회사는
                                        각 개별서비스에서 서비스의 제공을 위하여 제3자에게 제공되는 회원의 구체적인 회원정보를 명시하고 회원의 개별적이고
                                        명시적인 동의를 받은 후 동의의 범위 내에서 해당 서비스의 제공 기간 동안에 한하여 회원의 개인정보를 제3자와 공유하는
                                        등 관련 법령을 준수합니다.<br> &nbsp;<br> &nbsp;<br> <strong>제
                                            13 조 (회원의 의무)</strong><br> &nbsp;<br> ① 회원은 아래 각 호의 1에 해당하는 행위를
                                        하여서는 아니 됩니다.<br> &nbsp;&nbsp; 1. 회원가입신청 또는 변경 시 허위내용을 등록하는 행위<br>
                                        &nbsp;&nbsp; 2. 회사의 서비스에 게시된 정보를 변경하거나 서비스를 이용하여 얻은 정보를 회사의 사전 승낙
                                        없이 영리 또는 비영리의 목적으로 복제, 출판, 방송 등에 사<br>
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 용하거나 제3자에게 제공하는 행위<br>
                                        &nbsp;&nbsp; 3. 회사가 제공하는 서비스를 이용하여 제3자에게 본인을 홍보할 기회를 제공 하거나 제3자의
                                        홍보를 대행하는 등의 방법으로 금전을 수수하거나 서비스를 이<br>
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 용할 권리를 양도하고 이를 대가로 금전을 수수하는 행위<br>
                                        &nbsp;&nbsp; 4. 회사 기타 제3자에 대한 허위의 사실을 게재하거나 지적재산권을 침해하는 등 회사나 제3자의
                                        권리를 침해하는 행위<br> &nbsp;&nbsp; 5. 다른 회원의 ID 및 비밀번호를 도용하여 부당하게
                                        서비스를 이용하는 행위<br> &nbsp;&nbsp; 6. 정크메일(junk mail), 스팸메일(spam
                                        mail), 행운의 편지(chain letters), 피라미드 조직에 가입할 것을 권유하는 메일, 외설 또는 폭력적인
                                        메시지•화상•음성 등이 담긴 메일을 보내거나 기타 공서양속에 반하는 정보를 공개 또는 게시하는 행위<br>
                                        &nbsp;&nbsp; 7. 정보통신망법 등 관련 법령에 의하여 그 전송 또는 게시가 금지되는 정보(컴퓨터 프로그램
                                        등)를 전송하거나 게시하는 행위<br> &nbsp;&nbsp; 8. 청소년보호법에서 규정하는 청소년유해매체물을
                                        게시하는 행위<br> &nbsp;&nbsp; 9. 공공질서 또는 미풍양속에 위배되는 내용의 정보, 문장,
                                        도형, 음성 등을 유포하는 행위<br> &nbsp;&nbsp; 10. 회사의 직원이나 서비스의 관리자를
                                        가장하거나 사칭하여 또는 타인의 명의를 모용하여 글을 게시하거나 메일을 발송하는 행위<br>
                                        &nbsp;&nbsp; 11. 컴퓨터 소프트웨어, 하드웨어, 전기통신 장비의 정상적인 가동을 방해, 파괴할 목적으로
                                        고안된 소프트웨어 바이러스, 기타 다른 컴퓨터 코드, 파일, 프로<br>
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 그램을 포함하고 있는 자료를 게시하거나 전자우편으로
                                        발송하는 행위<br> &nbsp;&nbsp; 12. 어그로(Aggravation), 분탕질,
                                        스토킹(stalking), 욕설, 글 도배 등 다른 회원의 서비스 이용을 방해하는 행위<br>
                                        &nbsp;&nbsp; 13. 다른 회원의 개인정보를 그 동의 없이 수집, 저장, 공개하는 행위<br>
                                        &nbsp;&nbsp; 14. 불특정 다수의 회원을 대상으로 하여 광고 또는 선전을 게시하거나 스팸메일을 전송할
                                        목적으로 회사에서 제공하는 프리미엄 메일 기타 서비스를 이용하<br>
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 여 영리활동을 하는 행위<br>
                                        &nbsp;&nbsp; 15. 회사가 제공하는 소프트웨어 등을 개작하거나 리버스 엔지니어링, 디컴파일, 디스어셈블 하는
                                        행위<br> &nbsp;&nbsp; 16. 현행 법령, 회사가 제공하는 서비스에 정한 약관 기타 서비스 이용에
                                        관한 규정을 위반하는 행위<br> &nbsp;<br> ② 회사는 회원이 제1항의 행위를 하는 경우
                                        해당 게시물 등을 삭제 또는 임시삭제할 수 있고 서비스의 이용을 제한하거나 일방적으로 본 계약을 해지할 수 있습니다.<br>
                                        &nbsp;<br> &nbsp;<br> <strong>제 14 조 (양도금지)</strong><br>
                                        &nbsp;<br> 회원의 서비스 받을 권리는 이를 양도 내지 증여하거나 질권의 목적으로 사용할 수 없습니다.<br>
                                        &nbsp;<br> &nbsp;<br> <strong>제 15 조 (이용계약의 해지)</strong><br>
                                        &nbsp;<br> ① 회원이 서비스 이용계약을 해지하고자 하는 때에는 언제든지 회원정보관리에서 회사가 정한
                                        절차에 따라 회원의 ID를 삭제하고 탈퇴할 수 있습니다.<br> &nbsp;<br> ② 회원이
                                        제13조의 규정을 위반한 경우 회사는 일방적으로 본 계약을 해지할 수 있고, 이로 인하여 서비스 운영에 손해가 발생한
                                        경우 이에 대한 민, 형사상 책임도 물을 수 있습니다.<br> &nbsp;<br> ③ 회원이 서비스를
                                        이용하는 도중, 연속하여 일(1)년 동안 서비스를 이용하기 위해 회사의 서비스에 log-in한 기록이 없는 경우 회사는
                                        회원의 회원자격을 상실시킬 수 있습니다.<br> &nbsp;<br> ④ 본 이용 계약이 해지된 경우
                                        회원의 쪽지, 마이피와 같이 본인 개인 영역에 등록된 ‘쪽지글, 게시글 등’ 일체는 삭제됩니다만 다른 회원에 의해
                                        스크랩되어 게시되거나 공용 게시판에 등록된 ‘게시물 등’은 삭제되지 않습니다.<br> &nbsp;<br>
                                        &nbsp;<br> &nbsp;<br> <strong>제 4 장 기타</strong><br>
                                        &nbsp;<br> &nbsp;<br> <strong>제 16 조 (청소년 보호)</strong><br>
                                        &nbsp;<br> 회사는 모든 연령대가 자유롭게 이용할 수 있는 공간으로써 유해 정보로부터 청소년을 보호하고
                                        청소년의 안전한 인터넷 사용을 돕기 위해 정보통신망법에서 정한 청소년보호정책을 별도로 시행하고 있으며, 구체적인 내용은
                                        서비스 초기 화면 등에서 확인할 수 있습니다.<br> &nbsp;<br> &nbsp;<br>
                                        <strong>제 17 조 (면책)</strong><br> &nbsp;<br> ① 회사는 다음 각
                                        호의 경우로 서비스를 제공할 수 없는 경우 이로 인하여 회원에게 발생한 손해에 대해서는 책임을 부담하지 않습니다.<br>
                                        &nbsp;&nbsp; 1. 천재지변 또는 이에 준하는 불가항력의 상태가 있는 경우<br>
                                        &nbsp;&nbsp; 2. 서비스 제공을 위하여 회사와 서비스 제휴계약을 체결한 제3자의 고의적인 서비스 방해가 있는
                                        경우<br> &nbsp;&nbsp; 3. 회원의 귀책사유로 서비스 이용에 장애가 있는 경우<br>
                                        &nbsp;&nbsp; 4. 제1호 내지 제3호를 제외한 기타 회사의 고의∙과실이 없는 사유로 인한 경우<br>
                                        &nbsp;<br> ② 회사는 CP가 제공하거나 회원이 작성하는 등의 방법으로 서비스에 게재된 정보, 자료,
                                        사실의 신뢰도, 정확성 등에 대해서는 보증을 하지 않으며 이로 인해 발생한 회원의 손해에 대하여는 책임을 부담하지
                                        아니합니다.<br> &nbsp;<br> &nbsp;<br> <strong>제
                                            18 조 (분쟁의 해결)</strong><br> &nbsp;<br> 본 약관은 대한민국법령에 의하여 규정되고
                                        이행되며, 서비스 이용과 관련하여 회사와 회원간에 발생한 분쟁에 대해서는 민사소송법상의 주소지를 관할하는 법원을
                                        합의관할로 합니다.<br> &nbsp;<br> &nbsp;<br> <strong>제
                                            19 조 (규정의 준용)</strong><br> &nbsp;<br> 본 약관에 명시되지 않은 사항에 대해서는
                                        관련법령에 의하고, 법에 명시되지 않은 부분에 대하여는 관습에 의합니다.<br> &nbsp;<br>
                                        본 약관은 2018년 11월 1일부터 적용됩니다.
                                    </p>
                                </div>
                                <div class="confirm">
                                    <label class="d-flex" for="accept_agreement_1"> 
                                    	<input type="checkbox" name="accept_agreement[1]" value="Y" id="accept_agreement_1" required>
                                        위의 내용을 모두 읽었으며 동의합니다.
                                    </label>
                                </div>
                            </article>
                            <article class="agreement">
                                <div class="title">개인정보 수집 및 이용에 대한 동의 (필수)</div>
                                <div class="text">
                                    <p>
                                        1. 개인정보 취급방침이란<br> 이용자에게 다양한 서비스를 제공함에 있어 아래 기준을 준수합니다.<br>
                                        귺빈개발자 도서관은 이용자의 ‘동의를 기반으로 개인정보를 수집·이용 및 제공’ 하고 있으며, ‘이용자의 권리 (개인정보
                                        자기결정권)를 적극적으로 보장’ 합니다.<br> 귺빈개발자 도서관은 정보통신서비스제공자가 준수하여야 하는 대한민국의 관계
                                        법령 및 개인정보보호 규정, 가이드라인을 준수하고 있습니다.<br> “개인정보취급방침”이란 이용자의 소중한
                                        개인정보를 보호함으로써 이용자가 안심하고 서비스를 이용할 수 있도록 귺빈개발자 도서관이 준수해야 할 지침을 의미합니다.<br>
                                        &nbsp;
                                    </p>
                                    <p>2. 개인정보 수집</p>
                                    <p>
                                        이용자로부터 다음과 같은 개인정보를 수집하고 있습니다.<br> 모든 이용자는 귺빈개발자 도서관이 제공하는 서비스를 이용할
                                        수 있고, 회원가입을 통해 더욱 다양한 서비스를 제공받을 수 있습니다.<br> 이용자의 개인정보를 수집하는
                                        경우에는 반드시 사전에 이용자에게 해당 사실을 알리고 동의를 구하도록 하겠습니다.<br> 수집방법에는 서비스
                                        이용, 이벤트 응모, 고객센터, 팩스, 전화 등이 있으며, 아래의 원칙을 준수하고 있습니다.<br>
                                        &nbsp;<br> &nbsp;&nbsp; - 서비스 제공에 필요한 최소한의 개인정보를 수집합니다.<br>
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 개인정보 수집 항목 : 아이디, 비밀번호, 이메일, 본인확인값
                                    </p>
                                    <p>
                                        &nbsp;&nbsp; - 민감 정보를 수집하지 않습니다.<br>
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 민감정보란? : 이용자의 소중한 인권을 침해할 우려가 있는
                                        정보(인종, 사상 및 신조, 정치적 성향이나 범죄기록, 의료정보 등)<br>
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 단, 법령에서 민감 정보의 처리를 요구하거나 허용하는 경우에는
                                        반드시 사전에 이용자에게 해당 사실을 알리고 동의를 구하도록 하겠습니다.
                                    </p>
                                    <p>
                                        &nbsp;&nbsp; - 서비스 이용과정에서 아래와 같은 정보들이 자동으로 생성되어 수집될 수 있습니다.<br>
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP 주소, 쿠키, 방문 일시, 서비스 이용 기록, 불량 이용
                                        기록
                                    </p>
                                    <p>
                                        &nbsp;<br> 3. 개인정보 이용
                                    </p>
                                    <p>
                                        이용자의 개인정보를 다음과 같은 목적으로만 이용하며, 목적이 변경 될 경우에는 사전에 이용자에게 동의를 구하도록
                                        하겠습니다.<br> &nbsp;<br> &nbsp;&nbsp; - 이용자 식별, 가입의사 및 연령
                                        확인, 불량회원 부정이용 방지, 만 14세 미만 아동 개인정보 수집 시 법정 대리인 동의여부 확인, 법정 대리인
                                        권리행사 시<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 본인 확인<br>
                                        &nbsp;&nbsp; - 다양한 서비스 제공, 문의사항 또는 불만 처리, 공지사항 전달<br>
                                        &nbsp;&nbsp; - 이용자와 약속한 서비스 제공, 유료 서비스 구매 및 이용 시 요금 정산<br>
                                        &nbsp;&nbsp; - 신규 서비스 개발, 이벤트 행사 시 정보 전달, 마케팅 및 광고 등에 활용<br>
                                        &nbsp;&nbsp; - 서비스 이용 기록과 접속 빈도 분석, 서비스 이용에 대한 통계, 맞춤형 서비스 제공, 서비스
                                        개선에 활용
                                    </p>
                                    <p>
                                        이용자의 개인정보를 수집 및 이용 목적, 이용 기간에만 제한적으로 이용하고 있으며, 탈퇴를 요청하거나 동의를 철회하는
                                        경우 지체 없이 파기합니다.<br> &nbsp;<br> 다만, 이용약관 15조 2항에 의해 ID가
                                        정지 된 회원의 재가입을 막기 위해 본인확인값을 보관합니다.<br> <br> 4. 개인정보 제공
                                    </p>
                                    <p>
                                        본인확인 서비스를 위해 KCB에 업무를 위탁하고 있습니다.<br> <br> 5. 개인정보 파기<br>
                                        이용자의 개인정보에 대해 개인정보의 수집·이용 목적이 달성된 후에는 해당 정보를 지체 없이 파기합니다.<br>
                                        &nbsp;<br> 다만, 관계법령에 의해 보관해야 하는 정보는 법령이 정한 기간 동안 보관한 후 파기하며,
                                        이용약관 15조 2항에 의해 ID가 정지 된 회원의 재가입을 막기 위해 본인확인값을 보관합니다.
                                    </p>
                                    <p>
                                        <br> 6. 기타사항
                                    </p>
                                    <p>
                                        14세 미만 아동을 포함한 이용자의 권리를 보호하고 있습니다.<br> &nbsp;<br> 이용자의
                                        권리를 다음과 같이 보호하고 있습니다.<br> &nbsp;<br> &nbsp;&nbsp; - 언제든지
                                        자신의 개인정보를 조회하고 수정할 수 있습니다.<br> &nbsp;&nbsp; - 언제든지 개인정보 제공에
                                        관한 동의철회/회원가입해지를 요청할 수 있습니다.<br> &nbsp;&nbsp; - 만 14세 미만 아동의
                                        법정대리인의 법령 상의 권리를 보장합니다.(아동의 개인정보에 대한 열람, 정정·삭제, 개인정보처리정지요구권)<br>
                                        &nbsp;&nbsp; - 정확한 개인정보의 이용 및 제공을 위해 수정이 완료될 때까지 이용자의 개인정보는 이용되거나
                                        제공되지 않습니다.
                                    </p>
                                    <p>
                                        이미 제3자에게 제공된 경우에는 지체 없이 제공받은 자에게 사실을 알려 수정이 이루어질 수 있도록 하겠습니다.<br>
                                        &nbsp;<br> 쿠키Cookie를 설치, 운영하고 있고 이용자는 이를 거부할 수 있습니다.<br>
                                        &nbsp;<br> 쿠키는 이용자에게 보다 빠르고 편리한 웹사이트 사용을 지원하고 맞춤형 서비스를 제공하기
                                        위해 사용됩니다.<br> &nbsp;<br> &nbsp;<br> &nbsp;<br>
                                        개인정보보호 책임자<br> 책임자 : 한규빈 (lve2514@naver.com)
                                    </p>
                                    <p>&nbsp;</p>
                                    <p>
                                        또한 개인정보가 침해되어 이에 대한 신고나 상담이 필요하신 경우에는 아래 기관에 문의하셔서 도움을 받으실 수 있습니다.<br>
                                        &nbsp;<br> 개인정보침해신고센터 (http://privacy.kisa.or.kr / 국번없이 118)<br>
                                        대검찰청 사이버수사과 (http://www.spo.go.kr / 국번없이 1301)<br> 경찰청 사이버안전국
                                        (http://cyberbureau.police.go.kr / 국번없이 182)
                                    </p>
                                    <p>
                                        <br> - 개인정보취급방침 시행일자 : 2018년 11월 1일
                                    </p>
                                </div>
                                <div class="confirm">
                                    <label class="d-flex" for="accept_agreement_2"> <input type="checkbox" name="accept_agreement[2]" value="Y" id="accept_agreement_2" required>
                                        위의 내용을 모두 읽었으며 동의합니다.
                                    </label>
                                </div>
                            </article>
                            <form class="join-field-wrap" action="/member/join/" method="post">
                                <div class="d-flex field-box">
                                    <label for="id-input">아이디</label>
                                    <div class="input-box">
                                    	<div class="field-input-box">
                                        	<input id="id-input" class="field-input" type="text" name="id">
                                        	<img class="check-ok" src="/img/member/input_ok.png" alt="" />
                                        </div>
                                        <p class="id-input-tip tip">아이디를 입력해주세요</p>
                                    </div>
                                </div>
                                <div class="d-flex field-box">
                                    <label for="pwd-input">비밀번호</label>
                                    <div class="input-box">
                                    	<div class="field-input-box">
	                                        <input id="pwd-input" class="field-input" type="password" name="password">
	                                        <img class="check-ok" src="/img/member/input_ok.png" alt="" />
                                        </div>
                                       	<p class="pwd-input-tip tip">8~20자의 영문 대/소문자, 숫자, 특수문자(!@#$%^*+=-)를 사용하세요.</p>
                                    </div>
                                </div>
                                <div class="d-flex field-box">
                                    <label for="rePwd-input">비밀번호 확인</label>
                                    <div class="input-box">
                                    	<div class="field-input-box">
                                        	<input id="rePwd-input" class="field-input" type="password">
                                         	<img class="check-ok" src="/img/member/input_ok.png" alt="" />
                                        </div>
                                        <p class="rePwd-input-tip tip"></p>
                                    </div>
                                </div>
                                <div class="d-flex field-box">
                                    <label for="name-input">이름</label>
                                    <div class="input-box">
                                    	<div class="field-input-box">
                                        	<input id="name-input" class="field-input" type="text" name="name">
                                        	<img class="check-ok" src="/img/member/input_ok.png" alt="" />
                                       	</div>
                                        <p class="name-input-tip tip"></p>
                                    </div>
                                </div>
                                <div class="d-flex field-box">
                                    <label>성별</label>
                                    <div class="gender-box input-box">
                                    	<input class="gender-input" type="hidden" name="gender"/>
                                       	<div class="d-flex gender-input-box">
                                       		<div class="gender man">남자</div>
                                       		<div class="gender woman">여자</div>
                                       	</div>
                                       	<p class="gender-tip tip"></p>
                                    </div>
                                </div>
                                <div class="d-flex field-box">
                                    <label for="year-input">생년월일</label>
                                    <div class="birth-box input-box">
                                    	<div class="d-flex birth-input-box">
	                                        <input id="year-input" class="year-input" type="hidden" name="birth">
	                                        <select id="year-select" class="col-4 birth-select year-select" name="year-input">												
	                                            <option>년도</option>
	                                            <option>2007</option>
	                                            <option>2008</option>
	                                            <option>2006</option>
	                                            <option>2005</option>
	                                            <option>2004</option>
	                                            <option>2003</option>
	                                            <option>2002</option>
	                                            <option>2001</option>
	                                            <option>2000</option>
	                                            <option>1999</option>
	                                            <option>1998</option>
	                                            <option>1997</option>
	                                            <option>1996</option>
	                                            <option>1995</option>
	                                            <option>1994</option>
	                                            <option>1993</option>
	                                            <option>1992</option>
	                                            <option>1991</option>
	                                            <option>1990</option>
	                                            <option>1989</option>
	                                            <option>1988</option>
	                                            <option>1987</option>
	                                            <option>1986</option>
	                                            <option>1985</option>
	                                            <option>1984</option>
	                                            <option>1983</option>
	                                            <option>1982</option>
	                                            <option>1981</option>
	                                            <option>1980</option>
	                                            <option>1979</option>
	                                            <option>1978</option>
	                                            <option>1977</option>
	                                            <option>1976</option>
	                                            <option>1975</option>
	                                            <option>1974</option>
	                                            <option>1973</option>
	                                            <option>1972</option>
	                                            <option>1971</option>
	                                            <option>1970</option>
	                                            <option>1969</option>
	                                            <option>1968</option>
	                                            <option>1967</option>
	                                            <option>1965</option>
	                                            <option>1964</option>
	                                            <option>1963</option>
	                                            <option>1962</option>
	                                            <option>1961</option>
	                                            <option>1960</option>
	                                            <option>1959</option>
	                                            <option>1958</option>
	                                            <option>1957</option>
	                                            <option>1956</option>
	                                            <option>1955</option>
	                                            <option>1954</option>
	                                            <option>1953</option>
	                                            <option>1952</option>
	                                            <option>1951</option>
	                                            <option>1950</option>
	                                            <option>1949</option>
	                                            <option>1948</option>
	                                            <option>1947</option>
	                                            <option>1946</option>
	                                            <option>1945</option>
	                                            <option>1944</option>
	                                            <option>1943</option>
	                                            <option>1942</option>
	                                            <option>1941</option>
	                                            <option>1940</option>
	                                            <option>1939</option>
	                                            <option>1938</option>
	                                            <option>1937</option>
	                                            <option>1936</option>
	                                            <option>1935</option>
	                                            <option>1934</option>
	                                            <option>1933</option>
	                                            <option>1932</option>
	                                            <option>1931</option>
	                                            <option>1930</option>
	                                            <option>1929</option>
	                                            <option>1928</option>
	                                            <option>1927</option>
	                                            <option>1926</option>
	                                            <option>1925</option>
	                                            <option>1924</option>
	                                            <option>1923</option>
	                                            <option>1922</option>
	                                            <option>1921</option>
	                                            <option>1920</option>
	                                            <option>1919</option>
	                                            <option>1918</option>
	                                            <option>1917</option>
	                                            <option>1916</option>
	                                            <option>1915</option>
	                                            <option>1914</option>
	                                            <option>1913</option>
	                                            <option>1912</option>
	                                            <option>1911</option>
	                                        </select>
	                                        <input id="month-input" class="month-input" type="hidden" name="birth">
	                                        <select id="month-select" class="col-4 birth-select month-select" name="month-input">
	                                            <option>월</option>
	                                            <option>01</option>
	                                            <option>02</option>
	                                            <option>03</option>
	                                            <option>04</option>
	                                            <option>05</option>
	                                            <option>06</option>
	                                            <option>07</option>
	                                            <option>08</option>
	                                            <option>09</option>
	                                            <option>10</option>
	                                            <option>11</option>
	                                            <option>12</option>
	                                        </select>
	                                        <input id="day-input" class="day-input" type="hidden" name="birth">
	                                        <select id="day-select" class="col-4 birth-select day-select" name="day-input">
	                                            <option>일</option>
	                                            <option>01</option>
	                                            <option>02</option>
	                                            <option>03</option>
	                                            <option>04</option>
	                                            <option>05</option>
	                                            <option>06</option>
	                                            <option>07</option>
	                                            <option>08</option>
	                                            <option>09</option>
	                                            <option>10</option>
	                                            <option>11</option>
	                                            <option>12</option>
	                                            <option>13</option>
	                                            <option>14</option>
	                                            <option>15</option>
	                                            <option>16</option>
	                                            <option>17</option>
	                                            <option>18</option>
	                                            <option>19</option>
	                                            <option>20</option>
	                                            <option>21</option>
	                                            <option>22</option>
	                                            <option>23</option>
	                                            <option>24</option>
	                                            <option>25</option>
	                                            <option>26</option>
	                                            <option>27</option>
	                                            <option>28</option>
	                                            <option>29</option>
	                                            <option>30</option>
	                                            <option>31</option>	
	                                       </select>
                                   	   </div>
                                       <p class="birth-tip tip"></p>   
                                   	</div>
                                </div>
                                <div class="d-flex field-box">
                                    <label for="phone-input">연락처</label>
                                    <div class="input-box">
                                    	<div class="field-input-box">
                                        	<input id="phone-input" class="field-input" type="number" name="phone">
                                        	<img class="check-ok" src="/img/member/input_ok.png" alt="" />
                                        </div>
                                        <p class="phone-input-tip tip">'-' 를 빼고 연락처를 입력해주세요.</p>
                                    </div>
                                </div>
                                <div class="d-flex field-box">
                                    <label for="email-input">이메일</label>
                                    <div class="email-box input-box">
                                        <div class="d-flex email-input-box">
                                     		<input id="email-input" class="field-input" type="email" name="email">
                                            <button type="button" class="btn email-btn">인증메일 전송하기</button>
                                        </div>
                                        <p class="email-input-tip tip">이메일을 입력해주세요.</p>
                                        <div class="check-box">
	                                        <div class="d-flex mt-2">
	                                            <input class="field-input check-input" type="text" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" maxlength='6' disabled="disabled">
	                                            <button type="button" class="btn check-btn" disabled>확인</button>
	                                        </div>
	                                        <p class="check-input-tip"></p>
                                        </div>	
                                    </div>
                                </div>
                                <div class="d-flex join-btn-box">
                                    <button type="button" class="btn me-1 join-btn">등록</button>
                                    <a href="/"><button type="button" class="btn cancle-btn">취소</button></a>
                                </div>
                            </form>
                        </div>
                    </div>
                    

                </div>
            </div>
        </div>
		<jsp:include page="/WEB-INF/views/include/footer.jsp" />
    </div>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"
        integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous">
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/js/main.js"></script>
    <script src="/js/member/join.js"></script>
</body>
</html>