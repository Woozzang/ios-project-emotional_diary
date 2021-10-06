# Emotional Diary

<img src="/Resources/ezgif-1-7ec76987bbad.gif" width="50%">

<br /><br />

### 사용 기술 : `StackView`, `NotificationCenter`, `CustomView`
<br />
<br />

# 기능

사용자가 9가지 감정버튼을 클릭할 때마다 그 클릭 카운트를 앱이 종료되어도 그 데이터를 보존할 수 있게 구현한다.
<br />

## 구현 방법

클릭 카운트를 디스크 ( 모바일 기기이므로 낸드 플래시 메모리 ) 에 저장하면,

앱이 종료되어도  앱 샌드박스 내에서 그 데이터를 가지고 있게 된다.

다시 앱을 실행 했을 때 그 데이터를 사용할수 있음은 물론이다!

→ **UserDefaults** 를 사용해보자 (목표 달성!!!!!!!!!)
<br /><br />

<img src="/Resources/ezgif-1-c3179d60b50f.gif" width="50%">

# 정리해볼 점

1. UserDefaults 의 특징과 한계점, 그리고 실제로 어떤 기능 구현을 위해 사용할까?
    - TIL 에 적어놓음

2. 비슷한 성격으로 로컬에 Persistant 한 데이터를 저장하는 방법은 어떤 것이 또 있을까?
    - CoreData, Realm 등
<br /><br />

# Key-Value 형태 말고 객체를 저장할 수 있는 방법은?🔥

UserDefaults 는 Key-Value 형태로 기본 자료형들을 저장하는데에는 무리가 없다.

하지만 객체를 저장하고 싶을 때는 어떤 것을 사용해야 할까?

→  애플에서는 `NSKeyedAchiever` 를 이용해 Data(NSData) 형식으로 변환해서 저장하라고 권장하고 있습니다.

공부할거 또 생김...................... `NSKeyedArchiever`
<br /><br />

# 구현하면서 고민한 이슈
<br />

### 이게 정답인가??

정답은 없다. 일단 구현되는 코드를 빠르게 만들고 개선을 하는 방식으로 우선 진행해보자.
<br />

### 왜  NotificationCenter 인가?

Target-Action 로 구체적인 연결성을 가지기보다 노티로 처리하면 뷰를 재사용할 수 있다.

→ 결과적으로 나는 커스텀뷰를 다른 VC 에서도 재사용할 수 있게 되었당
<br />

### **의도에 맞지 않은 메서드를 사용하여 이유를 찾느라 고생했다.**

시스템 에셋 과 앱 자체의 에셋을 가져오는 메서드가 다르다.

→ SFSymbol 이미지 를 만들고 싶었는데, UIImage(named:) 메서드를 사용하였다.

→ 적절한 메서드는 UIImage(systemName:) 이고, 사용하는 메서드에 동작과 의도는 잘 파악하고 있어야겠다고 생각했다. 문서를 잘 읽자!!!

→ 또한 안되는 이유를 찾는 효율적인 방법도 고민해보자

이미지를 생성해서 넣었는데 안보이는 이유는 뭘까? 사실 이미지가 생성되지 않은 것이 아닐까? 라는 의문이라던가

- 나는 생성한 이미지의 width 값이 0인 것을 확인하고 제약과 관련이 있지 않을까라고 처음에 추측했었다.
- 이번 기회에 조금 더 튜닝된 접근 방법을 가지게 될 것 같다.
<br />

### 일자 모양의 레이아웃을 새로 만들어야할때 스택 뷰를 우선 고려해보자
<br />
<img src="/Resources/Screen_Shot_2021-10-06_at_8.58.22_PM.png" width="100">

<br />

나는 이것을 모르고 오랜 시간을 들여서 새로운 커스텀뷰 (CustomEmotionView) 를 만들었다.

스택뷰를 활용하면 여러 제약 설정을 줄일 수 있기 때문에 생산성이 증가할 것이다.

단순히 완성된 뷰를 스택뷰에 넣어주는 개념만 생각했었는데, 뷰 자체를 스택뷰로 구성한다는 발상은 동료를 통해 깨닫게 되었다.
<br />

### 고정된 크기의 스택뷰에 고정된 크기의 뷰를 넣으면 제약 오류가 발생한다

일단 넣고 크기 고정시키는거랑 구분해야함!!!!!! 

내가 고생한건 크기가 고정된 뷰를 고정된 크기의 스택뷰에 넣는 거임

여러 개를 넣음으로서 결과적으로 원하는 제약의 크기가 되더라도, 순서대로 집어넣는 것이기 때문에(코드로 넣는다면) 오류가 발생한다. 이것으로 시간을 많이 날렸다.