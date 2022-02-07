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
    @State var gastos = [Gasto]()

    var aPagarEsteMes : Double {
        var pagar = 0.0
        for gasto in gastos {
            pagar += gasto.importedelMes
        }
        return pagar
    }
    var body: some View {
        NavigationView{
            VStack(spacing: 0){
                List{
                    ForEach(gastos.filter({ elemento in
                        Calendar.current.dateComponents([.year,.month], from: elemento.fechaPago) == Calendar.current.dateComponents([.year,.month], from: Date())
                    })){ gasto in
                        VStack{
                            Text(gasto.nombre)
                                .font(.title)
                                .fontWeight(.bold)
                            Text("$\(gasto.importedelMes,specifier: "%.2f")")
                                .font(.body)
                                
                        }
                    
                }
                    .onDelete(perform: borrar)
            }
                Text("A pagar este mes $\(aPagarEsteMes,specifier: "%.2f")")
                            .font(.headline)
                            .fontWeight(.bold)
                            
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
                        NuevoGastoView(gastos : $gastos)
                            .navigationBarTitle(Text("Nuevo Gasto"))}})
                .onAppear(perform: cargaDatos)
                .navigationTitle(
                    Text("Tus Compras")
                )
        
        }
    }
    
    func borrar(al numero: IndexSet){
        gastos.remove(atOffsets: numero)
        guardarDato()
    }
    
    func getDirectorio()->URL{
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            return paths[0]
        }
        
        
        
        func cargaDatos(){
            let filename = getDirectorio().appendingPathComponent("LugaresGuardados")
            do {
                let data = try Data(contentsOf: filename)
                self.gastos = try JSONDecoder().decode([Gasto].self, from: data) //dato que se cargara
            } catch {
                print("no se puede cargar")
            }

        }
    
    func guardarDato(){
        do {
            let filename = getDirectorio().appendingPathComponent("LugaresGuardados")
            let data = try JSONEncoder().encode(self.gastos) //dato que se guardara
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("no se pudo guardar")
        }


    }
    
    

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
