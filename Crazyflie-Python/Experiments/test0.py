# Importar todo desde el paquete Crazyflie-Python
from .. import *

# Ahora puedes usar directamente todas las funciones importadas sin especificar
uri = 'radio://0/80/2M/E7E7E7E7E7'
scf = connect(uri)
if scf:
    flow_deck_detected = detect_flow_deck(scf)
    disconnect(scf)