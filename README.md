# 원티드 프리온보딩 iOS 코스

## 필수 구현 사항
### 애플리케이션 설명
- Open Weather의 API를 활용하여 다음의 조건을 충족하는 iOS 앱을 구현합니다.
### 첫 번째 화면

---

- 아래 각 도시의 현재 날씨를 화면에 표시합니다.
    - 필수로 포함해야 하는 정보
        - 도시이름, 날씨 아이콘, 현재기온, 현재습도
            
            > 공주, 광주(전라남도), 구미, 군산, 대구, 대전, 목포, 부산, 서산, 서울, 속초, 수원, 순천, 울산, 익산, 전주, 제주시, 천안, 청주, 춘천
            > 
        - 날씨 아이콘의 경우 API에서 제공하는 아이콘을 활용합니다.
- 첫 번째 화면의 각 도시 정보를 선택하면 두 번째 화면으로 이동합니다

### 두 번째 화면

---

- 첫 번째 화면에서 선택한 도시의 현재 날씨 상세 정보를 표현합니다
    - 필수로 포함해야 하는 정보
        - 도시이름, 날씨 아이콘, 현재기온, 체감기온, 헌재습도, 최저기온, 최고기온, 기압, 풍속, 날씨설명
- 날씨 아이콘 이미지를 불러올땐 캐시를 활용합니다.
    - 캐시된 정보가 있다면 캐시된 이미지를 활용합니다.
    - 캐시된 정보가 없다면 API로부터 이미지를 받아옵니다.
## 프로젝트 설명 
국내에서 실 디바이스에 배포 시 현재 유저의 위치를 확인하고 위치의 날씨를 확인할 수 있으며 주요 20개의 도시의 현재 날씨를 확인할 수 있습니다.

또한 내가 마지막으로 조회한 시간을 확인할 수 있고 재조회를 통해 모든 정보를 최신화할 수 있습니다.

## 디자인 패턴

MVVM 패턴

## 위치정보 및 날씨 정보 가져오기

Open Weather의 API를 사용하여 20개의 주요 도시의 날씨 정보를 가져오도록 하고 모든 정보를 불러온 이후 Icon 값에 따라 이미지를 다운로드 받도록 하였습니다.

또한 국내에서 실 디바이스에 배포 시 현주소를 Naver Rever Segeocode API를 통해 확인하여 현 사용자 주소 정보를 가져오도록 하였고
Open Weather의 API를 사용하여 사용자의 날씨 정보 또한 가져올 수 있도록 처리하였습니다.

이를 순서대로 하기 위하여 escaping closure를 사용하여 Call back 받은 이후 차례대로 작업을 수행하도록 하였습니다.

## App Icon 및 런치 스크린 설정

![KakaoTalk_Photo_2022-06-15-22-35-30 002](https://user-images.githubusercontent.com/66667091/173840608-71e9cb15-7fea-4894-b6e7-f534ce443010.jpeg)

프리온보딩 iOS 심볼 이미지를 사용하여 App Icon과 Launch Screen을 꾸며 보았습니다.

## 로딩 페이지

![KakaoTalk_Photo_2022-06-15-22-35-30 001](https://user-images.githubusercontent.com/66667091/173840882-447ed893-2ae5-4fb0-bad4-ada8c4046bbc.jpeg)

API 통신이 완료되고 이미지 다운로드가 완료되어 모든 데이터가 바인딩 된 이후 로딩 페이지가 사라지도록 하였습니다.

## 메인페이지

![KakaoTalk_Photo_2022-06-15-22-35-30 004](https://user-images.githubusercontent.com/66667091/173840991-d96e116f-bd60-4e99-acfb-b633e6781608.jpeg)

상단에 최근 조회한 시간을 확인할 수 있으며 재조회 버튼을 통해 날씨 정보를 최신화할 수 있습니다.

가운데에는 사용자의 위치 주소 및 날씨 정보가 표시됩니다. 클릭 시 날씨 상세 정보 페이지로 Modal이 나타나게 됩니다.

하단에는 주요 도시 20개의 이름과 날씨 정보 온도 / 습도를 표시하도록 하였으며 모든 정보를 보기 쉽도록 horizontal 방향으로 이동하도록 하였습니다.

Cell 클릭 시 날씨 상세 정보 페이지로 Modal이 나타나게 됩니다.

## 날씨 상세 페이지 이동

![KakaoTalk_Photo_2022-06-15-22-35-30 003](https://user-images.githubusercontent.com/66667091/173840746-ef40d850-0c90-497b-a324-aa491b92fa3c.jpeg)

NavgationController보다는 페이지가 2개뿐이기 때문에 사용자가 Modal나타나게하여 빠르게 확인하고 다시 메인 화면으로 돌아올 수 있도록 하기 위해 모달을 사용하여 페이지 이동하였습니다.

그리고 요구사항대로 도시 이름, 날씨 아이콘, 현재가 온, 체감기온, 헌재 습도, 최저기온, 최고기온, 기압, 풍속, 날씨 설명을 표시하였습니다.

## MVC에서 MVVM으로 변경

MVC 방식으로 프로젝트를 완성한 이후 MVVM패턴으로 바꾸고 싶었습니다. 그래서 다른 교육자료를 참조하여 부족하지만 MVVM패턴을 사용하여 코드를 리팩토링해 보았습니다.

## 아쉬운점

CollectionView의 Scroll 방식을 페이징 방식으로 하고 싶었지만, UI 관련된 세부 지식이 부족하여 구현해내지 못하였습니다. 하지만 이를 외부 라이브러리 없이 적용하고 싶습니다.
