//
//  NuevoGastoView.swift
//  MonthlyBill
//
//  Created by Pablo Pizarro on 05/02/2022.
//

import SwiftUI

struct Gasto{
    
    var nombre : String
    var importe : Double
    var tipoGasto : String
    var cantidadCuotas : Int?
    var importeCuotas : Int?
    var fechaPago : Date
    var mesSiguiente = false
    var fechaFin : Date
}

struct NuevoGastoView: View {
    @Environment(\.presentationMode) var modoPresen
    @State var nombre = ""
    @State var importe = 0
    @State var importeStr = ""
    @State var cantidadCuotas = ""
    @State var fechaPago = Date()
    @State var fechaPagoC = DateComponents()
    
    var tipoPago = ["Un Pago", "Cuotas","Suscripción"]
    @State var seleccionTipoPago = "Un Pago"
    var body: some View {
            Form{
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
                // MARK: boton guardado
                Section{
                    Button(action:{
                    },label: {
                        Text("Guardar")
                            .font(.title2)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)})
                }
                      
            }.navigationBarItems(trailing: Button("Salir"){
                self.modoPresen.wrappedValue.dismiss()})
            

        
    }
    
    func guardarDato(){
        print("cuotas")
    }
}

struct NuevoGastoView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NuevoGastoView()
        }
    }
}
