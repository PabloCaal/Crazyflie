# Importar todo desde el paquete Crazyflie-Python
from .. import *

# Definir la URI del Crazyflie
uri = 'radio://0/80/2M/E7E7E7E7E7'  # Asegúrate de que esta URI corresponde a tu Crazyflie

# Conexión al Crazyflie
scf = connect(uri)

if scf:
    try:
        # Detectar el Flow Deck
        flow_deck_detected = detect_flow_deck(scf)
        
        if flow_deck_detected:            
            takeoff(scf, height=0.5, duration=1.5)
            time.sleep(1.5)  
            land(scf)
    
    except Exception as e:
        print(f"Error durante la rutina: {str(e)}")
    
    finally:
        disconnect(scf)
else:
    print("Error al conectar con el Crazyflie.")
