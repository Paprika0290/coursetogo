# 🗺️ CourseToGo
지역별 맛집 등의 데이터를 기반으로 만들어진 데이트 및 모임 코스를 추천하는 서비스입니다.<br>
현재 지역은 서울로 한정되어 있으며, 네이버 Map API를 활용한 화면에서 유저가 직접 코스를 제작하고 공유할 수 있습니다.

- - - 

### ⏳ 개발 기간
2023.06.15 - 3034.07.25
- - -
### 📚 기술 스택
#### - Frontend
- HTML / CSS
- Javascript
- JSP
    
#### - Backend
- Java 8
- Spring Boot
- Gradle
- MyBatis

#### - Database
- Oracle DB/SQL

#### - API
- 네이버 로그인 API
- 네이버 지도 API
- - -
### 📕 ERD
![](https://i.imgur.com/xIosxUQ.png)
- - -
### 🚀 주요 기능

#### - 유저 기능
- 네이버 로그인 API를 활용한 간편한 회원가입/로그인 기능
- 유저 MyPage 기능 (유저가 작성한 코스, 작성한 리뷰, 북마크한 코스 조회)
- 코스 작성 수, 코스리뷰 작성 수, 장소리뷰 작성 수에 따른 랭킹 기능
  
#### - 코스 기능 / 코스 제작
- 네이버 지도 API를 활용하여 화면 및 기능 구성
- 지역 키워드(ex. 홍대, 강남역, 이태원...)와 업종명(ex. 카페,영화관...)으로 검색된 장소 정보 결과를 표시
- 유저가 장소를 선택하면, 선택 순서에 따라 코스(장소의 조합)가 생성
#### - 코스 기능 / 코스 조회
- 생성된 코스는 페이징이 적용된 리스트뷰 형식으로 모든 유저가 조회 가능
- 지역 키워드로 코스 검색
- 유저의 검색 기록에 맞춘 코스 추천 기능

#### - 리뷰 기능
- 코스에 대한 리뷰 및 별점 기능
- 장소에 대한 별점 기능
