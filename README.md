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
<img height="600" width="384" alt="스크린샷 2022-06-19 오후 12 36 06" src="https://user-images.githubusercontent.com/75964073/174464693-fc05f4a1-56fe-49e4-a863-8d8b2844b0a9.png">


### 두 번째 화면
---
- 첫 번째 화면에서 선택한 도시의 현재 날씨 상세 정보를 표현합니다
    - 필수로 포함해야 하는 정보
        - 도시이름, 날씨 아이콘, 현재기온, 체감기온, 헌재습도, 최저기온, 최고기온, 기압, 풍속, 날씨설명
- 날씨 아이콘 이미지를 불러올땐 캐시를 활용합니다.
    - 캐시된 정보가 있다면 캐시된 이미지를 활용합니다.
    - 캐시된 정보가 없다면 API로부터 이미지를 받아옵니다.

<img height="600" width="406" alt="스크린샷 2022-06-19 오후 12 48 45" src="https://user-images.githubusercontent.com/75964073/174464706-688e0f13-7c87-46e9-9035-6a8c978c0880.png">



## 프로젝트 설명 
사용한 컴포넌트: TableView, StackView, UIButton

navigationBar 오른쪽에 reload 버튼을 추가하여 날씨 정보를 실시간으로 받아올 수 있게 하였습니다.

단일 열 안에 행을 사용하여 데이터를 나타내기 위해 TableView를 사용하였고 "가나다"순으로 지역을 배치하기 위해 미리 정해둔 정적 데이터인 titles, numberOfCities, cities Array의 인덱스를 사용하여 테이블 셀 안에 지역이름, 날씨아이콘, 기온, 습도를 표시하였습니다.

셀을 클릭하면 접근성을 편하게 하기 위해 상세 정보 페이지를 modal로 나타내었으며 포함해야 하는 정보들이 나타납니다. 기온, 습도, 기압 등 날씨의 value를 가진 키값들을 가지고 있는 arrayOfTemperature의 이전, 이후 인덱스로 이동할 수 있는 left, right UIButton을 사용하여 해당 날씨 정보를 나타내도록 하였습니다.이렇게한 이유는 사용자 입장에서 귀찮을 수 있지만 정신없이 나열하기 보다는 한 정보를 한번에 출력하고 싶었기 때문입니다.


## 디자인 패턴

MVC 패턴


## HomeController

<img width="384" alt="스크린샷 2022-06-19 오후 12 36 06" src="https://user-images.githubusercontent.com/75964073/174464742-7b338806-65bd-4aa5-8737-5d50bff4b930.png">

날씨 정보를 담는 data입니다. key 값은 해당 지역의 이름으로 설정하였고 value는 데이터를 나타낸 Model인 WeatherResponse타입을 받도록 하였습니다.
(셀이 재사용되면서 이전 셀에서 셋팅한 이미지가 남아있는 문제가 발생하지 않도록 하기 위해 prepareForeReuse를 사용하여 이미지뷰의 이비지를 초기화하는 과정을 거쳤습니다.)

<img width="389" alt="스크린샷 2022-06-19 오후 12 36 01" src="https://user-images.githubusercontent.com/75964073/174464733-10664945-2737-42b1-9fcd-c3a66b425e31.png">

openWeatherAPI의 데이터를 가져오는 함수입니다. 호출되는 위치는 View가 뿌려지고 데이터를 가져오는데 시간을 조금이라도 줄이기 위해 ViewWillAppear와 reload 버튼에 호출하도록 하였습니다.
처음에는 data를 빠르게 가져오기 위해 각 tableCell 별로 쓰레드를 사용하여 값을 가져오고 reloaData하도록 하였지만 이렇게 하면 처음에 스크롤 하기 전 cell들의 image가 보이지 않는 오류가 발생해  Webservice의 escaping closure를 모든 cell의 작업이 끝나고 call back을 받고난 뒤 reload하도록 변경하였습니다.  


## SecondViewController
<img width="619" alt="스크린샷 2022-06-19 오후 12 48 41" src="https://user-images.githubusercontent.com/75964073/174465059-04cf4918-fbf1-4c44-8aa8-962456d93629.png">
HomeController에서 cell을 클릭하고 data를 받는 data 변수와 버튼 가운데에 있는 지금 무엇을 나타내는지에 대한 label을 표현해주는 arrayOfWhatLabel과 같은 크기와 인덱스를 가지는 arrayOfTemperature 배열입니다.

<img width="406" alt="스크린샷 2022-06-19 오후 12 48 45" src="https://user-images.githubusercontent.com/75964073/174465100-8e8f986b-a7e1-476e-9063-3614c4ca98d6.png">

localizing을 위해 NSLocalizedString을 사용하였으며 각 label마다 해당하는 데이터를 할당하였습니다.

<img width="406" alt="스크린샷 2022-06-19 오후 12 48 45" src="https://user-images.githubusercontent.com/75964073/174465137-1da7456e-b081-4f43-bc4e-f4a21ab027e2.png">
누르면 arrayOfWhatLabel와 arrayOfTemperature의 index를 1씩 올려주어 데이터를 변경시켜주는 rightButtonClick IBAction 함수와 반대로 index를 -1해주다가 음수가 되면 다시 마지막 index로 이동하는 leftButtonClick 함수입니다.   


## Webservice
<img width="272" alt="스크린샷 2022-06-19 오후 12 48 09" src="https://user-images.githubusercontent.com/75964073/174465176-2b4f91ac-b93e-4848-bf5e-c6aa3029a06e.png">
<img width="362" alt="스크린샷 2022-06-19 오후 12 48 11" src="https://user-images.githubusercontent.com/75964073/174465184-c5ea37f9-dc03-4e01-8806-bb08963be693.png">

싱글턴 객체와 만들어서 메모리 낭비 방지하였고, cache를 만들어 image를 재사용하기 위해 로컬 캐시를 만들었습니다.

<img width="893" alt="스크린샷 2022-06-19 오후 12 48 16" src="https://user-images.githubusercontent.com/75964073/174465236-af035c4c-33af-4201-bf54-f6bdbaf6e8f2.png">
<img width="697" alt="스크린샷 2022-06-19 오후 12 48 22" src="https://user-images.githubusercontent.com/75964073/174465311-63709186-55cb-44c8-a06c-c0468e86d92a.png">
   
cell 단위로 작업을 끝내지 않기 위해 WeatherData 딕셔너리를 선언하고 completion에 Result 타입을 사용하여 보다 직관적으로 success와 failure 나누어 코드를 작성하였습니다.
API 호출 후 completion closure 내부에서 강한순환참조가 발생하여 [weak self]를 써주어 strong reference cycle이 발생하지 않도록 하였습니다.  

이미지의 경우 캐시를 먼저 확인하고 해당 데이터가 없다면 받아오도록 하였습니다.
