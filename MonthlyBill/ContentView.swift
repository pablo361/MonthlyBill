//
//  ContentView.swift
//  MonthlyBill
//
//  Created by Pablo Pizarro on 05/02/2022.
//

import SwiftUI

struct ContentView: View {
    @State var mostrarView = false
    var tipoPago = ["Un Pago", "Cuotas","Suscripción"]
    @State var seleccionTipoPago = "Un Pago"
    var body: some View {
        NavigationView{
            Form{
                Text("Hello, world!")
                    .padding()
                Picker("Tipo",selection: $seleccionTipoPago){
                    ForEach(tipoPago,id:\.self){
                        Text($0)
                    }
                }
                }
                .navigationBarItems(trailing: Button(
                action:{
                    self.mostrarView.toggle()
                },
                label: {
                    Image(systemName: "plus")
                }))
                .sheet(isPresented: $mostrarView, content: {
                    NavigationView{
                        NuevoGastoView()
                            .navigationBarTitle(Text("Nuevo Gasto"))
                    }
                })
        
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
