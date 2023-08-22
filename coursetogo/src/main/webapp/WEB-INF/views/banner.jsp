<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="../css/banner.css">
</head>
<body>
	<div class="banner" style = "margin-left: 200px;">
		<div class="imgcontanier">
			<img class="slideImg" src="/images/advertise2.png">
		</div>
		<div class="imgcontanier">
			<img class="slideImg" src="/images/advertise2.png">
		</div>
		<div class="imgcontanier">
			<img class="slideImg" src="/images/advertise2.png">
		</div>
		<div class="imgcontanier">
			<img class="slideImg" src="/images/advertise2.png">
		</div>
		<a class="prev" onclick="plusSlides(-1)">❮</a>
		<a class="next"onclick="plusSlides(1)">❯</a>
	</div>
	<br>
	<!-- 이미지 아래 현재 슬라이드 위치 표시 -->
	<div style="text-align: center">
		<span class="dot" onclick="currentSlide(1)"></span> 
		<span class="dot" onclick="currentSlide(2)"></span>
		<span class="dot" onclick="currentSlide(3)"></span>
		<span class="dot" onclick="currentSlide(4)"></span>
	</div>

<script>
	var slideIndex = 1; // 슬라이드의 현재 인덱스를 나타내는 변수
	
	showSlides(slideIndex); // 초기 슬라이드 표시
	setInterval(function() { plusSlides(1); }, 3000); // 5초마다 슬라이드 변경 함수 호출
	
	function plusSlides(n) {
	  showSlides(slideIndex += n); // 다음 또는 이전 슬라이드를 보여주는 함수
	}
	
	function currentSlide(n) {
	  showSlides(slideIndex = n); // 특정 슬라이드를 보여주는 함수
	}
	
	function showSlides(n) {
	  var i;
	  var slides = document.getElementsByClassName("imgcontanier"); // 슬라이드 요소들을 가져옴
	  var dots = document.getElementsByClassName("dot"); // 점 표시 요소들을 가져옴
	
	  if (n > slides.length) {
	    slideIndex = 1; // 슬라이드 인덱스가 슬라이드 개수를 초과하는 경우, 첫 번째 슬라이드로 이동
	  }
	  if (n < 1) {
	    slideIndex = slides.length; // 슬라이드 인덱스가 1보다 작은 경우, 마지막 슬라이드로 이동
	  }
	  
	  for (i = 0; i < slides.length; i++) {
	    slides[i].style.display = "none"; // 모든 슬라이드를 숨김
	  }
	  for (i = 0; i < dots.length; i++) {
	    dots[i].className = dots[i].className.replace(" active", ""); // 모든 점 표시를 비활성화
	  }
	
      // 현재 슬라이드를 표시하고, 트랜지션 클래스를 추가 및 제거하여 미끄러지는 효과 부여
      slides[slideIndex - 1].style.display = "block";
      slides[slideIndex - 1].querySelector(".slideImg").classList.add(n > 1 ? "next" : "prev");
      dots[slideIndex - 1].className += " active";

      // 트랜지션 클래스 제거를 위해 setTimeout 사용 (0.6초와 transition 속성의 시간을 맞춤)
      setTimeout(function() {
        slides[slideIndex - 1].querySelector(".slideImg").classList.remove("next", "prev");
      }, 6);
	}
</script>
</body>
</html>
