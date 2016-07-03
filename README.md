####REST
Rails에서는 REST architecture는 data를 만들수있고(created), 보여지고(shown), 수정되고(updated), 삭제되는(destroyed) `resource`로 나타내는 것 이다. 

####Git
`git checkout -f` local에서의 변경사항을 모두 버림.

`git checkout --track origin/test-branch` 는 local에 origin/test-branch와 같은 commit을 가진 test-branch라는 branch를 만든다.

`git branch -dr origin/login-logout` remote branch를 없앨 때는 `-dr` 옵션을 사용하자.

#####--without production
`bundle install --without production`

Gemfile에 production group에 정의된 gem들은 설치하지 않음.

#####Rails console
console에서 route helper 이용하려면

```
> include Rails.application.routes.url_helpers
> app.login_path

```


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
#### rails generate
`generate` 명령어는 `column`:`type` 형태로 argument를 받는다.
`--no-test-framework` option을 사용하면 test에 필요한 파일은 만들지 않는다.
`generate controller` controller 이름은 복수형으로 끝나게 하는게, convention을 적용하기에 편하다. (singular도 가능하긴 하다.)

`active_record`의 uniqueness validation이 `db` level에서의 uniqueness validation을 보장하지는 않는다.

<해결책>
`email` column에 대해서 index를 만들어서, index가 unique하도록 한다.
database의 index는 `책`의 index와 똑같이 동작한다. 모든 page에서 특정 단어(ex. banana)를 찾는게 full_table scan이면, index page에서 banana를 찾는게 index scan이다.

`fixture`에는 test database를 위한 sample data가 들어있다.

`model` class 내부에서 값 할당시 등호 오른쪽에서는 `self`를 생략할 수 있다.
`self.email = email.downcase`

`authenticate()`는 password가 맞으면 `User` object를 반환하는데, `!!authenticate()`으로 쓰면 password가 맞을 때 `true`를 반환한다.

[exercise regex: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i](http://rubular.com/r/tOmhu2Cf3N)


### Chapter 7.

Sass의 `mixin`은 css rule을 group화 시켜서 여기저기에 `@include` 시킬 수 있게 해준다.

`byebug`라는 gem 덕분에 code상에 `debug`라고 치기만 하면, server log 창에서 debugging을 할 수 있다.

`bundle exec rake db:migrate:reset`

`form`에서 에러가 발생하면 `Rails`가 자동으로 해당 field를 `field_with_errors` class를 가진 `div`로 감싼다.

Sass의 `@extend`는 기존에 정의된 class의 css 속성을 그대로 가져올 수 있게 한다.

```
.field_with_errors {
  @extend .has-error;
  .form-control {
    color: $state-danger-text;
  }
}
```

`assert_template` integration test에서 layout을 제대로 rendering하는지 확인

`redirect_to @user` == `redirect_to user_url(@user)`



### Chapter 8.
Rails는 `cookies`를 이용해서 sessions을 구현한다.

`form_for(@user)` 이건 `/users` URL에 `POST` action이라고 Rails가 이해한다.

`integration test`

1. invalid information --> assert_not

2. valid information --> assert

`ApplicationController`에 `include SessionsHelper`를 넣으면, 모든 view에서 helper module에 정의된 method를 사용할 수 있다.

`redirect_to user`에서 Rails는 자동으로 `user_url(user)`으로 바꿔준다.

`.find`는 찾는 대상이 없으면 exception을 날리고, `.find_by`는 `nil`을 반환한다.

`<%= link_to "Log out", logout_path, method: "delete" %>`

`helper` method는 test에서 사용할 수 없다.

같은 기능의 helper method를 development와 test에서 사용해야 한다면, 이름을 다르게 해서 헷갈리지 않도록 하자.

#####remember token
`attr_accessor :remember_token` database에 저장되지 않는 attribute인 `remember_token`을 사용할 수 있게 해준다. `user.remember_token`

test에 포함되지 않은 것 같은 code에 `raise`를 사용하면, test coverage에 포함되었는지 확인할 수 있다. exception이 발생하면 test가 되는 code이고, 아니라면 빠진 code이다.

the conventional order for the arguments to assert_equal is expected, actual:

### Chapter 9.

`form_for(@user)`는 `@user.new_record?`가 `true`이면 POST를 `false`이면 PATCH를 사용한다. 그래서 new.html.erb 와 edit.html.erb에 동일하게 `form_for(@user)`를 사용할 수 있다.

`validates`의 `allow_nil: true` option은 blank도 validation을 하지 않게 해준다. `nil`을 넘겼더니 error가 난다. 이상하다. 마치 `allow_nil: true`와 `allow_blank: true`가 같은 방식으로 동작하는 것 같다. `rails 4.2.2`


Here we call render not on a string with the name of a partial, but rather on a `user` variable of class User;9 in this context, Rails automatically looks for a partial called `app/views/users/_user.html.erb`, which we must create


### Chapter 11.

#### Meta-programming
프로그램을 만드는 프로그램
`send` method는 object에 `message`를 보낼 수 있게 해준다.

```
a.length
a.send(:length)
```


####iterate two arrays at once

```
arr1 = [e1]
arr2 = [e2]
arr1.zip(arr2).each do |e1, e2|
...
end
```
#### assing() in test
test code에 있는 action에서 사용되는 모든 `instance variable`이 저장된다.

```
<test.rb>
test `a test` do
post users_path(), user: {email:a@a.a, ...}
user = assigns(:user)
# user.email == a@a.a
end

<users_controller.rb>
def create
...
@user = User.new(users_params)
end
```

####Heroku
`heroku config:get SENDGRID_USERNAME`


### Chapter 12.
12.1.2 exercise 1 solution : model이 없기 때문에

#### Assign 하는 방법.
1. regular assign (`attribute=`)
database에 적용되지 않음.
`reload!`로 변경사항을 버리고 database의 값을 다시 가져올 수 있다.
2. `update_attribute`
validation없이 모델에 관여한다.
3. `update`
attribution을 바꾸고, validation 한 뒤 database에도 영향을 준다.
수정할 attribute가 단 하나라도 `update_attribute` 쓰지말고 `update`를 사용하자.


###Q. before filter에서 udpate_attribute 사용시 stack이 너무 길어 알기어려운 error가 integration test 진행시 발생.

####