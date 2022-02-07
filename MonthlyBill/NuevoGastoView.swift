//
//  NuevoGastoView.swift
//  MonthlyBill
//
//  Created by Pablo Pizarro on 05/02/2022.
//

import SwiftUI

struct Gasto: Identifiable, Codable{
    var id = UUID()
    var nombre : String
    var importe : Double
    var tipoGasto : String
    var cantidadCuotas : Int?
    var importedelMes : Double
    var fechaPago : Date
   // var mesSiguiente = false
    //var fechaFin : Date
}

struct NuevoGastoView: View {
    @Environment(\.presentationMode) var modoPresen
    @State var nombre = ""
    @State var importe = 0
    @State var importeStr = "0"
    @State var cantidadCuotas = "1"
    @State var fechaPago = Date()
    @State var fechaPagoC = DateComponents()
    @Binding var gastos : [Gasto]

    var importeFooter : Double {
        if seleccionTipoPago == "Cuotas"{
           
            return (Double(importeStr) ?? 0) / (Double(cantidadCuotas) ?? 1)
            
        }
        else {
            return Double(importeStr) ?? 0
        }
    }
    
    var tipoPago = ["Un Pago", "Cuotas","Suscripción"]
    @State var seleccionTipoPago = "Un Pago"
    var body: some View {
            Form{
                Section(footer: Text("Pago $\(importeFooter,specifier: "%.2f")")
                            .font(.headline)
                            .fontWeight(.bold)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .trailing)
                            ){
                    TextField("Nombre", text: $nombre)
                    TextField("Importe", text: $importeStr)
                        .keyboardType(.decimalPad)
                    Picker("Tipo",selection: $seleccionTipoPago){
                        ForEach(tipoPago,id:\.self){
                            Text($0)
                        }
                    }
                    if seleccionTipoPago == "Cuotas" {
                        TextField("Cantidad de Cuotas", text: $cantidadCuotas)
                            .keyboardType(.numberPad)
                    }
                    DatePicker("Fecha", selection: $fechaPago,displayedComponents: .date)
                }
                // MARK: boton guardado
                Section{
                    Button(action:{
                        guardarDato()
                        
                    },label: {
                        Text("Guardar")
                            .font(.title2)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)})
                    Button(action:{
                        self.modoPresen.wrappedValue.dismiss()
                    },label: {
                        Text("Cancelar")
                            .font(.title2)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)})
                        .foregroundColor(.red)
                }
                      
            }.navigationBarItems(trailing: Button("Salir"){
                self.modoPresen.wrappedValue.dismiss()})
            

        
    }
    
    func guardarDato(){
        let gasto = Gasto(nombre: self.nombre, importe: Double(self.importeStr) ?? 0, tipoGasto: self.seleccionTipoPago, cantidadCuotas: Int(self.cantidadCuotas) ?? 1, importedelMes: importeFooter , fechaPago: fechaPago)
        gastos.append(gasto)
        do {
            let filename = getDirectorio().appendingPathComponent("LugaresGuardados")
            let data = try JSONEncoder().encode(self.gastos) //dato que se guardara
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("no se pudo guardar")
        }
        self.modoPresen.wrappedValue.dismiss()


    }
    
    
    func getDirectorio()->URL{
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            return paths[0]
        }

}

//struct NuevoGastoView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            NuevoGastoView()
//        }
//    }
//}
