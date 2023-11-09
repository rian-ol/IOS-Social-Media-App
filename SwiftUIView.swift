import SwiftUI

struct LoginView: View {
//    @EnvironmentObject var AuthView : AuthView
    @State var username = ""
    @State var password = ""
    @State var Login: Bool = false
    @FocusState private var focusedField: Field?

    enum Field {
        case  username, password
    }
    
    var body: some View {
        
       
        NavigationStack {
            VStack {
                    HStack(alignment: .top){
                        Text("App Name")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                        
                    }.frame(height: 200)
                    
                    VStack (spacing: 40) {
                        VStack (spacing: 15){
                            TextField("Username", text: $username)
                                .focused($focusedField, equals: .username)
                                .submitLabel(.next)
                                .onSubmit {
                                    focusedField = .password
                                }
                            Divider()
                            
                        }
                        VStack(spacing: 15) {
                            SecureField("Password", text: $password)
                                .focused($focusedField, equals: .password)
                                .submitLabel(.done)
                            Divider()
                        }
                    }
                    .foregroundColor(Color.black)
                    .font(.headline)
                    .disableAutocorrection(true)
                    .padding(.top, 44)
                    .padding(.horizontal, 45)
                    .onTapGesture {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                    
                    VStack {
                         
                            Button {
                                //                AuthView.login(username: username, password: password )
                                Login = true
                               
                                
                            } label: {
                                Text("Login")
                                    .font(.title)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.white)
                                    .frame(width: 340, height: 50)
                                    .background(Color.black)
                                    .clipShape(Capsule())
                                    .padding()
                            }
                            .navigationDestination(isPresented: $Login){
//                                HomeView().navigationBarBackButtonHidden(true)
                            }
                            
                        
//                        NavigationLink(destination: RegisterView().navigationBarBackButtonHidden(true)) {
                            Text("Sign up")
                                .font(.title2)
                                .fontWeight(.bold)
                        }
//                        VStack(alignment: .leading){
//                            Button{
//                                Register = true
//                            }label:{
//                                Text("Sign up")
//                                    .font(.title2)
//                                    .fontWeight(.bold)
//
//                            }
//                        }.navigationDestination(isPresented: $Register){RegisterView().navigationBarBackButtonHidden(true)}
                        
                        
                    }.padding(.top)
                    Spacer()
            }
        }
        
        
    }
//}


import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var authView: AuthView
    @State private var email = ""
    @State private var password2 = ""
    @State private var username = ""
    @State private var password = ""
    @State private var register: Bool = false
    @FocusState private var focusedField: Field?

    enum Field {
        case email, password2, username, password
    }

    var body: some View {
        VStack(spacing: 40) {
            if focusedField == nil {
                VStack(spacing: 50) {
                    Text("App Name")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                   
                    Text("Create a new account.")
                        .font(.title2)
                        .fontWeight(.semibold)
                }
                .frame(height: 200)
            }
           
            VStack(spacing: 15) {
                TextField("Student email", text: $email)
                    .focused($focusedField, equals: .email)
                    .textContentType(.emailAddress)
                    .submitLabel(.next)
                    .onSubmit {
                        focusedField = .username
                    }
                Divider()
            }
           
            VStack(spacing: 15) {
                TextField("Username", text: $username)
                    .focused($focusedField, equals: .username)
                    .submitLabel(.next)
                    .onSubmit {
                        focusedField = .password
                    }
                Divider()
            }
           
            VStack(spacing: 15) {
                SecureField("Password", text: $password)
                    .focused($focusedField, equals: .password)
                    .submitLabel(.next)
                    .onSubmit {
                        focusedField = .password2
                    }
                Divider()
            }
           
            VStack(spacing: 15) {
                SecureField("Re-enter password", text: $password2)
                    .focused($focusedField, equals: .password2)
                    .submitLabel(.done)
                    .onSubmit {
                        focusedField = nil
                    }
                Divider()
            }
           
            Button(action: {
                register = true
            }) {
                Text("Create account")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.white)
                    .frame(width: 340, height: 50)
                    .background(Color.black)
                    .clipShape(Capsule())
                    .padding()
            }
            .navigationDestination(isPresented: $register) {
//                HomeView().navigationBarBackButtonHidden(true)
            }
           
            NavigationLink(destination: LoginView().navigationBarBackButtonHidden(true)) {
                Text("Login to existing account")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color.blue)
            }
           
            Spacer()
        }
        .foregroundColor(Color.black)
        .font(.headline)
        .disableAutocorrection(true)
        .padding(.top, 44)
        .padding(.horizontal, 45)
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .padding(.top)
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}

