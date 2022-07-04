<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>규비개발자 도서관 - Kyubhin Developer Library</title>
    <link rel="icon" href="/img/digital-library.png" type="image/x-icon">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
        integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="/css/facilityInfo/roomStatus.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/include/sideMenu.jsp" />
    <div class="library-bg">
        <div class="shadow move-top-icon">
            <i class="fa-solid fa-arrow-up"></i>
        </div>
		<div class="shadow chat-icon-box">
			<img src="/img/main/chat-icon.png" alt="" />
		</div>
        <jsp:include page="/WEB-INF/views/include/menu.jsp" />
        <div class="library-main-bg">
            <div class="library-main-wrap">
                <div class="main-seatStatus-wrap">
                    <div class="seatStatus-box">
                        <div class="seatStatus-title">
                            <h1>열람실 이용현황</h1>
                        </div>
                        <div class="modal fade" id="roomModal" tabindex="-1" aria-labelledby="roomModalLabel" aria-hidden="true">
						  <div class="modal-dialog">
						    <div class="modal-content">
						      <div class="modal-header">
						        <h5 class="modal-title" id="roomModalLabel">좌석배정</h5>
						        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						      </div>
						      <div class="modal-body">
				      			<img class="roomMark-img" src="/img/facilityInfo/roomMark.png" alt="" /> 
					      		<h4 class="roomMark-num"></h4>
						        <div class="body-wrap">
						        	<div class="body-text-box d-flex">
					        	 	</div>
						        </div>
						        <div class="body-sub-box">
						        	<p>
							        	<span>Justice : What's the Right Thing to Do?</span>
							        	<br>
							        	최대한 편리하게 이용하고, 
							        	<br>
							        	깨끗하게 사용합시다.
						        	</p>
						        </div>
						        <div class="d-flex modal-footer">
						        	<button type="button" class="btn assign-btn" data-bs-dismiss="modal">배정</button>
						        	<button type="button" class="btn stop-btn" data-bs-dismiss="modal">사용중지</button>
						        	<button type="button" class="btn finish-btn" data-bs-dismiss="modal">이용종료</button>
					        	 	<button type="button" class="btn btn-warning close-btn" data-bs-dismiss="modal">닫기</button>
						        </div>
						      </div>
						    </div>
						  </div>
						</div>   
                        <div class="seatStatus-main">
                            <div class="main-wrap">
                                <div class="status-table-box">
                                    <div class="status-content">
                                        <div class="status-item-box">
                                            <h5>열람실 좌석</h5>
                                            <div>
                                                <table>
                                                    <thead>
                                                        <tr>
                                                            <th style="width:200px">명칭</th>
                                                            <th style="width:80px">전체</th>
                                                            <th style="width:100px">잔여좌석</th>
                                                            <th class="d-none d-md-table-cell">사용율</th>
                                                            <th style="width:80px">운영상태</th>
                                                            <th style="width:60px"></th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr id="room2-status">
                                                            <td class="room-name">2층 제 1열람실</td>
                                                            <td class="total-seat">108</td>
                                                            <td><span class="remaining-seat">108</span></td>
                                                            <td class="d-none d-md-table-cell">
                                                                <div class="progress seatSatus-progress">
                                                                    <div class="progress-bar seatSatus-progress-bar room2-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"><span class="bar-percent">0%</span></div>
                                                                </div>
                                                            </td>
                                                            <td class="seat-status">운영중</td>
                                                            <td>
                                                            	<input type="hidden" value="2"/>
                                                            	<button class="btn detail-btn">상세</button>
                                                            </td>
                                                        </tr>
                                                        <tr id="room3-status">
                                                            <td class="room-name">3층 제 2열람실</td>
                                                            <td class="total-seat">72</td>
                                                            <td><span class="remaining-seat">72</span></td>
                                                            <td class="d-none d-md-table-cell">
                                                                <div class="progress seatSatus-progress">
                                                                    <div class="progress-bar seatSatus-progress-bar room3-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"><span class="bar-percent">0%</span></div>
                                                                </div>
                                                            </td>
                                                            <td class="seat-status">운영중</td>
                                                            <td>
                                                            	<input type="hidden" value="3"/>
                                                            	<button class="btn detail-btn">상세</button>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                        <div class="status-item-box my-reservation-box">
                                            <h5>나의 자리</h5>
                                            <div>
                                                <table>
                                                    <thead>
                                                        <tr>
                                                            <th>명칭</th>
                                                            <th>좌석번호</th>
                                                            <th>예약시간</th>
                                                            <th>남은시간</th>
                                                            <th>좌석상태</th>
                                                            <th></th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr>
                                                            <td class="room-name">
                                                            </td>
                                                            <td class="seat-num"></td>
 															<td class="reservation-time"></td>
 															<td class="remain-time"></td>	
                                                            <td class="seat-status"></td>
                                                            <td class="seat-service"></td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div> 
                                </div>
                                <div class="seat-reservation-wrap">
                                    <div class="seat-tab-bg">
                                        <div class="d-flex tab-box">
                                            <div class="tab">
                                            	<input type="hidden" value="2"/>
                                                <p>2층 제 1열람실</p>
                                            </div>
                                            <div class="tab">
                                            	<input type="hidden" value="3"/>
                                                <p>3층 제 2열람실</p>
                                            </div>
                                        </div>         
                                    </div>
                                    <div id="room2-detail" class="seat-status-bg tab1">
                                        <div class="seat-status-title">
                                            <h3>좌석예약</h3>
                                            <input type="hidden" value="2">
                                        </div>
                                        <div class="shadow-sm seat-status-wrap">
                                            <div class="d-flex seat-status-box">
                                                <div class="d-flex seat-status-item">
                                                    <div class="item-box"><div class="cover-box"><span>1</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>2</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>3</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>4</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>5</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>6</span></div></div>
                                                </div>
                                                <div class="d-flex seat-status-item">
                                                    <div class="item-box"><div class="cover-box"><span>7</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>8</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>9</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>10</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>11</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>12</span></div></div>
                                                </div>
                                                <div class="d-flex seat-status-item">
                                                    <div class="item-box"><div class="cover-box"><span>13</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>14</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>15</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>16</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>17</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>18</span></div></div>
                                                </div>
                                            </div>
                                            <div class="d-flex seat-status-box">
                                                <div class="d-flex seat-status-item">
                                                    <div class="item-box"><div class="cover-box"><span>19</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>20</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>21</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>22</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>23</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>24</span></div></div>
                                                </div>
                                                <div class="d-flex seat-status-item">
                                                    <div class="item-box"><div class="cover-box"><span>25</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>26</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>27</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>28</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>29</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>30</span></div></div>
                                                </div>
                                                <div class="d-flex seat-status-item">
                                                    <div class="item-box"><div class="cover-box"><span>31</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>32</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>33</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>34</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>35</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>36</span></div></div>
                                                </div>
                                            </div>
                                            <div class="d-flex seat-status-box">
                                                <div class="d-flex seat-status-item">
                                                    <div class="item-box"><div class="cover-box"><span>37</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>38</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>39</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>40</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>41</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>42</span></div></div>
                                                </div>
                                                <div class="d-flex seat-status-item">
                                                    <div class="item-box"><div class="cover-box"><span>43</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>44</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>45</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>46</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>47</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>48</span></div></div>
                                                </div>
                                                <div class="d-flex seat-status-item">
                                                    <div class="item-box"><div class="cover-box"><span>49</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>50</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>51</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>52</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>53</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>54</span></div></div>
                                                </div>
                                            </div>
                                            <div class="d-flex seat-status-box">
                                                <div class="d-flex seat-status-item">
                                                    <div class="item-box"><div class="cover-box"><span>55</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>56</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>57</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>58</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>59</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>60</span></div></div>
                                                </div>
                                                <div class="d-flex seat-status-item">
                                                    <div class="item-box"><div class="cover-box"><span>61</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>62</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>63</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>64</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>65</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>66</span></div></div>
                                                </div>
                                                <div class="d-flex seat-status-item">
                                                    <div class="item-box"><div class="cover-box"><span>67</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>68</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>69</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>70</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>71</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>72</span></div></div>
                                                </div>
                                            </div>
                                            <div class="d-flex seat-status-box">
                                                <div class="d-flex seat-status-item">
                                                    <div class="item-box"><div class="cover-box"><span>73</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>74</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>75</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>76</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>77</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>78</span></div></div>
                                                </div>
                                                <div class="d-flex seat-status-item">
                                                    <div class="item-box"><div class="cover-box"><span>79</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>80</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>81</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>82</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>83</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>84</span></div></div>
                                                </div>
                                                <div class="d-flex seat-status-item">
                                                    <div class="item-box"><div class="cover-box"><span>85</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>86</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>87</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>88</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>89</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>90</span></div></div>
                                                </div>
                                            </div>
                                            <div class="d-flex seat-status-box">
                                                <div class="d-flex seat-status-item">
                                                    <div class="item-box"><div class="cover-box"><span>91</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>92</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>93</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>94</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>95</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>96</span></div></div>
                                                </div>
                                                <div class="d-flex seat-status-item">
                                                    <div class="item-box"><div class="cover-box"><span>97</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>98</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>99</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>100</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>101</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>102</span></div></div>
                                                </div>
                                                <div class="d-flex seat-status-item">
                                                    <div class="item-box"><div class="cover-box"><span>103</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>104</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>105</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>106</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>107</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>108</span></div></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="d-flex steat-status-bottom">
                                            <div>
                                                <div class="item-box"><div class="cover-box"></div></div>
                                                <h5>배정가능</h5>
                                            </div>
                                            <div>
                                                <div class="item-box"><div class="cover-box stop-sample"></div></div>
                                                <h5>사용불가</h5>
                                            </div>      
                                            <div>
                                                <div class="item-box"><div class="cover-box using-sample"></div></div>
                                                <h5>사용중</h5>
                                            </div>   
                                        </div>
                                    </div>
                                    <div id="room3-detail" class="seat-status-bg tab2">
                                        <div class="seat-status-title">
                                            <h3>좌석예약</h3>
                                            <input type="hidden" value="3">
                                        </div>
                                        <div class="shadow-sm seat-status-wrap">
                                            <div class="d-flex seat-status-box">
                                                <div class="d-flex seat-status-item">
                                                    <div class="item-box"><div class="cover-box"><span>1</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>2</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>3</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>4</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>5</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>6</span></div></div>
                                                </div>
                                                <div class="d-flex seat-status-item">
                                                    <div class="item-box"><div class="cover-box"><span>7</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>8</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>9</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>10</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>11</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>12</span></div></div>
                                                </div>
                                            </div>
                                            <div class="d-flex seat-status-box">
                                                <div class="d-flex seat-status-item">
                                                    <div class="item-box"><div class="cover-box"><span>13</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>14</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>15</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>16</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>17</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>18</span></div></div>
                                                </div>
                                                 <div class="d-flex seat-status-item">
                                                    <div class="item-box"><div class="cover-box"><span>19</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>20</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>21</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>22</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>23</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>24</span></div></div>
                                                </div>
                                            </div>
                                            <div class="d-flex seat-status-box">
                                                <div class="d-flex seat-status-item">
                                                    <div class="item-box"><div class="cover-box"><span>25</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>26</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>27</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>28</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>29</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>30</span></div></div>
                                                </div>
                                                <div class="d-flex seat-status-item">
                                                     <div class="item-box"><div class="cover-box"><span>31</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>32</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>33</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>34</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>35</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>36</span></div></div>
                                                </div>
                                            </div>
                                            <div class="d-flex seat-status-box">
                                                <div class="d-flex seat-status-item">
                                                    <div class="item-box"><div class="cover-box"><span>37</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>38</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>39</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>40</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>41</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>42</span></div></div>
                                                </div>
                                                <div class="d-flex seat-status-item">
                                                    <div class="item-box"><div class="cover-box"><span>43</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>44</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>45</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>46</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>47</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>48</span></div></div>
                                                </div>
                                            </div>
                                            <div class="d-flex seat-status-box">
                                                <div class="d-flex seat-status-item">
                                                    <div class="item-box"><div class="cover-box"><span>49</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>50</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>51</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>52</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>53</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>54</span></div></div>
                                                </div>
                                                <div class="d-flex seat-status-item">
                                                    <div class="item-box"><div class="cover-box"><span>55</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>56</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>57</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>58</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>59</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>60</span></div></div>
                                                </div>
                                            </div>
                                            <div class="d-flex seat-status-box">
                                                <div class="d-flex seat-status-item">
                                                    <div class="item-box"><div class="cover-box"><span>61</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>62</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>63</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>64</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>65</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>66</span></div></div>
                                                </div>
                                                <div class="d-flex seat-status-item">
                                                    <div class="item-box"><div class="cover-box"><span>67</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>68</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>69</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>70</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>71</span></div></div>
                                                    <div class="item-box"><div class="cover-box"><span>72</span></div></div> 
                                                </div>
                                            </div>
                                        </div>
                                        <div class="d-flex steat-status-bottom">
                                            <div>
                                                <div class="item-box"><div class="cover-box"></div></div>
                                                <h5>배정가능</h5>
                                            </div>
                                            <div>
                                                <div class="item-box"><div class="cover-box stop-sample"></div></div>
                                                <h5>사용불가</h5>
                                            </div>      
                                            <div>
                                                <div class="item-box"><div class="cover-box using-sample"></div></div>
                                                <h5>사용중</h5>
                                            </div>   
                                        </div>
                                    </div>
                                </div>
                            </div>
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
		var id = "${sessionScope.id}";
    </script>
    <script src="/js/facilityInfo/roomStatus.js"></script>
</body>