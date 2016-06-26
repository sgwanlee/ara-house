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

