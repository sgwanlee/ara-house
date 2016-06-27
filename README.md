#####--without production
`bundle install --without production`

Gemfile에 production group에 정의된 gem들은 설치하지 않음.

#####Test text highlighting
[gem minitest_reporter](http://chriskottom.com/blog/2014/06/dress-up-your-minitest-output/)

#####Provide
view마다 다른 변수를 할당.

in ***.html.erb

```
<% provide(:title, "Home")%>
```

####<%...%> <%=...%>
```<%...%>``` embedded ruby 실행

```<%=...%>``` embedded ruby 실행 후 결과값을 template에 넣기


###Chapter 3
view에서 helper 사용하는게 좋은건지 잘 모르겠다.

```image_tag``` helper 에서는 이미지가 변경될 때마다 고유한 이미지 이름을 생성한다. ```a``` tag로 만들었다면, 사용자가 cache를 없애기 전까지는 이전의 이미지가 그대로 사용된다.

+1 helper

#### Asset location

서버에서는 app/assets 이후에 /images, /javascripts, /stylesheets 등으로 디렉토리가 구별되어 있지만, 브라우저에서 접근할 때는 /assets 한 폴더에 있는 것 처럼 접근한다.

####Partial

Layout partial을 ```app/views``` 폴더에서 찾기 시작한다.
```<%= render 'layout/header %>``` render method는 ```aaa/views/layout/_header.html.erb``` 파일을 찾으려고 한다.


####Asset Pipeline
Rails 3.0 이후엔 세 개의 폴더에 asset이 저장된다. 

```app/assets``` 

```lib/assets``` 우리 팀에서 만든 libraries

 ```vendor/assets``` 3rd party libraries


Manifest(목록) files
```*= require_tree .``` 은 ```app/assets/stylesheets```의 모든 css 파일을 application.css 파일로 합친다.

Rails에서는 css파일은 ```application.css```으로 javascript 파일은 ```application.js```으로 합쳐주고, minify까지 해준다.


#### Sass
#### Named routes
```get 'help' => 'static_pages#help'```은 ```help_path```와 ```help_url```을 만든다.

#### Integration Test
`assert_select "a[href=?]", about_path` `?`자리에 `about_path`를 넣는다.

#### Test에서 helper 사용
```test_helper.rb```의 `class ActiveSupport::TestCase`에 `include ApplicationHelper`추가


###Chapter6.

`generate` 명령어는 `column`:`type` 형태로 argument를 받는다.

`active_record`의 uniqueness validation이 `db` level에서의 uniqueness validation을 보장하지는 않는다.

<해결책>
`email` column에 대해서 index를 만들어서, index가 unique하도록 한다.
database의 index는 `책`의 index와 똑같이 동작한다. 모든 page에서 특정 단어(ex. banana)를 찾는게 full_table scan이면, index page에서 banana를 찾는게 index scan이다.

`fixture`에는 test database를 위한 sample data가 들어있다.

`model` class 내부에서 값 할당시 등호 오른쪽에서는 `self`를 생략할 수 있다.
`self.email = email.downcase`

`authenticate()`는 password가 맞으면 `User` object를 반환하는데, `!!authenticate()`으로 쓰면 password가 맞을 때 `true`를 반환한다.