<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>대출/반납 - 규비개발자 도서관</title>
    <link rel="icon" href="/img/main/digital-library.png" type="image/x-icon">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
        integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="/css/bookInfo/returnOfLoan.css">
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
                        <span>도서이용안내</span>
                        <i class="fa-solid fa-angle-right"></i>
                        <a href="/bookInfo/returnOfLoan"><span>대출/반납</span></a>
                    </div>
                </div>
                <div class="main-bookInfo-wrap">
                    <div class="bookInfo-box">
                        <div class="bookInfo-title">
                            <h1>대출/반납</h1>
                        </div>    
                        <div class="bookInfo-main">
                            <div class="main-wrap">
                                <div class="info-box">
                                    <div class="d-flex info-title" style="border-top: 1px solid #cfcfda">
                                        <h4>대출책수 및 기간</h4>
                                        <i class="fa-solid fa-angle-down i-active"></i>
                                    </div>
                                    <div class="info-content active">
                                        <table>
                                            <thead>
                                                <tr>
                                                    <th>구분</th>
                                                    <th>책수</th>
                                                    <th>기간</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>일반회원</td>
                                                    <td>5책 이내</td>
                                                    <td>14일</td>
                                                </tr>
                                                <tr>
                                                    <td>우대회원</td>
                                                    <td>10책 이내</td>
                                                    <td>20일</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                        <div class="info-item-box">
                                            <h5>참고사항</h5>
                                            <ul>
                                                <li>대출기간은 토요일, 공휴일 및 도서관 휴관일 등을 포함하여 계산
                                                    <br>
                                                    ※ 단, 반납예정일이 토요일, 공휴일 및 도서관 휴관일인 경우 그 다음 개관일로 자동 처리
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="info-box">
                                    <div class="d-flex info-title">
                                        <h4>대출 방법</h4>
                                        <i class="fa-solid fa-angle-down"></i>
                                    </div>
                                    <div class="info-content">
                                        <div class="info-item-box">
                                            <h5>자동대출기 이용 불가한 경우</h5>
                                            <ul>
                                                <li>홈페이지에서 도서 검색 후 상세정보의 소장정보에서 대출버튼을 클릭하여 예약</li>
                                                <li>도서관의 대출/반납데스크로 방문하여 대출</li>
                                                <li>대출처리 후 대출확인증 출력 권장
                                                    <br>
                                                    ※ 대출장소, 대출일, 대출자 ID, 대출도서의 등록번호, 반납예정일 등 확인 가능
                                                </li>
                                            </ul>
                                        </div>
                                        <div class="info-item-box">
                                            <h5>대출이 불가한 경우</h5>
                                            <ul>
                                                <li>신분별 대출 가능권수를 초과한 경우</li>
                                                <li>연체도서가 있는 경우</li>
                                                <li>연체료를 미납한 경우</li>
                                                <li>신분증 또는 도서관이용증이 없는 경우</li>  
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="info-box">
                                    <div class="d-flex info-title">
                                        <h4>반납 방법</h4>
                                        <i class="fa-solid fa-angle-down"></i>
                                    </div>
                                    <div class="info-content">
                                        <div class="info-item-box">
                                            <h5>반납</h5>
                                            <ul>
                                                <li>대출한 도서는 반납예정일 내에 대출하였던 도서관에 반납하는 것을 원칙으로 함</li>
                                            </ul>
                                        </div>
                                        <div class="info-item-box">
                                            <h5>대출/반납데스크 이용</h5>
                                            <ul>
                                                <li>딸림자료는 반드시 반납할 자료와 분리하여 반납대에 제출
                                                    <br>
                                                    ※ 딸림자료를 반납 도서에 끼워 반납할 경우 반납처리과정 중 딸림자료(디스켓이나 CD의 경우)의 데이터가 소실
                                                </li>
                                                <li>모니터를 통해 반납처리과정을 반드시 확인</li>

                                            </ul>
                                        </div>
                                        <div class="info-item-box">
                                            <h5>분실/훼손도서 변상</h5>
                                            <ul>
                                                <li>대출한 도서를 분실 또는 훼손하였을 경우 동일한 도서로 변상</li>
                                                <li>동일한 도서를 구할 수 없는 경우, 도서관 규정에 따라 유사한 주제의 도서로 변상</li>
                                                <li>변상도서의 처리에 필요한 자료정리비 별도 부가
                                                    <br>
                                                    ※ 동일본 도서정리비 1000원, 유사본 도서정리비 4,000원
                                                <li>도서를 분실하여 도서변상이 완료될 때까지 연체료는 계속 부과되므로 빠른 시일 내에 도서관에 변상 처리하여야 함</li>
                                                <li>분실 / 훼손자료에 대한 변상처리는 그 도서를 대출한 도서관의 대출/반납데스크에서 담당</li>
                                            </ul>
                                        </div>
                                        <div class="info-item-box">
                                            <h5>도서 연체 및 연체료 미납부 제재 안내</h5>
                                            <ul>
                                                <li>대출중지 및 연장불가
                                                    <br>
                                                    ※ 연체료는 1일 1책당 100원
                                            </ul>
                                        </div>  
                                    </div>
                                </div>
                                <div class="info-box">
                                    <div class="d-flex info-title">
                                        <h4>대출 연장</h4>
                                        <i class="fa-solid fa-angle-down"></i>
                                    </div>
                                    <div class="info-content">
                                        <div class="info-item-box">
                                            <h5>대출 연장</h5>
                                            <ul>
                                                <li>대출한 자료는 1회에 한하여 연장 가능
                                                    <br >
                                                    <span style="color: #555; font-weight: bold;">단, 예약 중인 도서는 연장할 수 없습니다.</span>
                                                </li>
                                                <li>연장 신청일로부터 대출기간만큼 연장</li>
                                            </ul>
                                        </div>
                                        <div class="info-item-box">
                                            <h5>연장 방법</h5>
                                            <ul>
                                                <li>도서관 홈페이지 [My Library] → [대출중인 도서] 메뉴 이용
                                                    <br>
                                                    ※ 로그인 후 대출을 연장하고자 하는 자료 우측의 [연장하기] 버튼 클릭
                                                    <br>
                                                    ※ 단, 반납예정일이 지났거나, 연체도서가 있거나, 해당 자료를 다른 이용자가 예약한 경우 연장 불가
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="info-box">
                                    <div class="d-flex info-title">
                                        <h4>예약 방법</h4>
                                        <i class="fa-solid fa-angle-down"></i>
                                    </div>
                                    <div class="info-content">
                                        <div class="info-item-box">
                                            <h5>이용 안내</h5>
                                            <ul>
                                                <li>다른 이용자가 대출한 자료를 미리 예약하는 제도</li>
                                                <li>자료가 반납되면 예약 순위에 따라 우선적으로 대출 가능</li>
                                            </ul>
                                        </div>
                                        <div class="info-item-box">
                                            <h5>예약 방법</h5>
                                            <ul>
                                                <li>홈페이지에서 도서 검색 후 상세정보의 소장정보에서 예약버튼을 클릭하여 예약</li>
                                                <li>자료가 반납되면 이메일과 SMS로 통보</li>
                                                <li>도서관의 대출/반납데스크로 방문하여 대출</li>
                                            </ul>
                                        </div>
                                        <div class="info-item-box">
                                            <h5>유의사항</h5>
                                            <ul>
                                                <li>1인당 예약 가능 책수 : 3책</li>
                                                <li>1책당 최대 3명까지 예약 가능</li>
                                                <li>예약자료 반납 통보(이메일, SMS) 후 대기 기간 : 3일 (통보 당일 포함)</li>
                                                <li style="color: #555; font-weight: bold;">
                                                    예약 도서 미대출 횟수가 3회(또는 3권) 이상 시 30일간 예약 서비스 이용 불가
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                
                            </div>
                        </div>
                    </div>
                </div>
                <div class="inquiry-wrap">
                    <div class="d-flex inquiry-box">
                        <div class="d-flex inquiry-title item">
                            <div class="">
                                <i class="fa-solid fa-question"></i>
                            </div>
                            <h4>문의하기</h4>
                        </div>
                        <div class="d-flex inquiry-phone item">
                            <i class="fa-solid fa-headphones"></i>
                            <h5>010-8285-5819</h5>
                        </div>
                        <div class="d-flex inquiry-location item">
                            <i class="fa-solid fa-location-dot"></i>
                            <h5>규비개발자 도서관</h5>
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
    <script>
        $('.info-title').click(function(){
            if($(this).parent().children('.info-content').css('display') === 'none'){
                $('.info-content').slideUp();
                $('.fa-angle-down').css('transform','none');
                $(this).children('.fa-angle-down').css('transform','rotate(180deg)');
                $(this).parent().children('.info-content').slideToggle();
            } else {
                $('.fa-angle-down').css('transform','none');
                $(this).parent().children('.info-content').slideUp();
            } 
        })


    </script>
</body>