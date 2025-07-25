This is a package to offer some convenient methods, extension, shortcut and a custom simple
state management solution to speed up the development

besides the extensions and methods which can be explored simply by looking at the files of the package
there are three noticeable things

## MyTextField

They are used to simplify dealing with text fields by offering multiple ready for use fields like
MyPasswordTextField which automatically configured to hide the password and show with a suffix eye button
MyRegisterPasswordTextField which applies a strong password regex to the password
MyConfirmPasswordField which takes another password controllers and compares it own text to the
provided one and throws an error if they are not the same

MyNameTextField, MyFirstNameTextField, MySecondNameTextField, MyLastNameTextField
which does not allow numbers to be entered and offer labels directly

MyEmailTextField which allows applies an email regex and keyboard

MyPhoneTextField which allows only numbers and applies a number keyboard

MyPhoneWithCountryTextField which places a country picker before, or in the field as a suffix or a prefix
and applies a quick formatter and regex for Egyptian numbers

the main parameter they take is the TextFieldModel

## TextFieldModel

The parameter taken by all MyTextFields

It is used to automatically applies different styles and info for the text fields while allowing all of them
to be completely customizable, you can replace any behavior in them by just providing it for the specific field
and it will be automatically replaced with what you provided, and it has some helpful parameters like
showPasswordVisibleIcon, enableAutoCorrection, focusedBorder (color) and so on

## state management and StateModel

This package has a very simple state management solution and a sealed class StateModel

### StateModel

this is a generic model that wraps it with the most common states like StateInitial, StateSuccess, StateError, StateLoading

instead of defining 4 states for each model in the client app which adds a significant amount of boilerplate

any model can be wrapped directly in it, it has valid equality checks and is state management independent, so it can
work with any solution (Riverpod, BLoC, Provider or GetX)

### state management

