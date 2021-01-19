
## JCS_Create 使用链式语法快速创建UI的工具库

原先创建Label的代码
```
let label = UILabel()
label.text = "用户昵称"
label.font = .systemFont(ofSize: 12)
label.textColor = .red
label.backgroundColor = .blue
label.textAlignment = .center
self.view.addSubview(label)
label.snp.makeConstraints { make in
    make.leading.trailing.equalTo(10)
    make.top.equalTo(100)
}
```

使用JCS_Create后
```
let label = UILabel(text: "用户昵称", font: .systemFont(ofSize: 12), color: .red)
    .jcs_textAlignment_Center()
    .jcs_backgroundColor(color: .blue)
    .jcs_layout(superView: self) { (make) in
        make.leading.trailing.equalTo(10)
        make.top.equalTo(100)
    }
```

原生创建UIButton
```
let button = UIButton()
button.setTitle("登陆", for: .normal)
button.setTitleColor(.red, for: .normal)
button.setBackgroundImage(UIImage(named: "login_bg"), for: .normal)
button.rx.controlEvent(.touchUpInside).subscribe(onNext: {
    print("执行登陆")
}).disposing(with: self)
self.view.addSubview(button)
button.snp.makeConstraints { (make) in
    make.center.equalTo(self.view)
    make.width.height.equalTo(100)
}
```

使用JCS_Create
```
UIButton()
    .jcs_title(title: "登陆")
    .jcs_titleColor(color: .red)
    .jcs_backgroundImage(image: UIImage(named: "login_bg"))
    .jcs_click { sender in
        print("执行登陆")
    }
    .jcs_layout(superView: self) { (make) in
        make.center.equalTo(self.view)
        make.width.height.equalTo(100)
    }
```
