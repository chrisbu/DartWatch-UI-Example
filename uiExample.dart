#library('uiExample');

#import('dart:html');
#import('../../dart-devel/dart/client/view/view.dart');

void main() {
  try {
    MainView mainView = new MainView();
    mainView.addToDocument(document.body);  
    
 //   MainView mainView2 = new MainView();
 //   MainView mainView3 = new MainView();
 //   mainView2.addToDocument(document.body);
 //   mainView3.addToDocument(document.body);

  }
  catch (Exception ex) {
    document.window.alert(ex.toString());
  }
  
}


class MainView extends CompositeView {
  
  
  MainView()  {
    
    View titleView = new View.html("<h1>Barely chirp</h1>");
    this.addChild(titleView);
    

    InputView inputView = new InputView();
    this.addChild(inputView);
    
    ChirpView chirpView = new ChirpView();
    ButtonView buttonView = new ButtonView(chirpView, inputView);
    
    this.addChild(buttonView);
    this.addChild(chirpView);
    
  }
}
  

class InputView extends View {
  InputElement chirpTextbox;
    
  Element render() {
    chirpTextbox = document.createElement("input");
//  uncomment these lines to put a message in the textbox which disappears when it gets the focus.
    chirpTextbox.value = "Enter some text";
    chirpTextbox.on.focus.add((e) {
      chirpTextbox.value = "";
    }); 
  return chirpTextbox;
  }
  
}


class ButtonView extends View {
  ChirpView chirpView;
  InputView inputView;
  ButtonElement chirpButton;
  
  ButtonView(this.chirpView, this.inputView);
    
  Element render() {
    chirpButton = document.createElement("button");
    chirpButton.text = "Post Your Chirp";
    return chirpButton;
  }
    
  void afterRender(Element node) {
    addOnClick((e) { 
      chirpView.addChirp(inputView.chirpTextbox.value);
//uncomment the following line to clear the input textbox when we've added something
     inputView.chirpTextbox.value = "";
    });
  }
    
}

class ChirpView extends View {
  DivElement _chirpList;
    
  Element render() {
    _chirpList = document.createElement("div");
    _chirpList.innerHTML = "";
    return _chirpList;
  }
  
  void addChirp(String chirp) {
    _chirpList.innerHTML = chirp + "<br />" + _chirpList.innerHTML;
  }
}