#!/usr/bin/env bash

set -xeuo pipefail

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
ROOT_SCH=${SCRIPT_DIR}/Kicad/neotron-pico.kicad_sch
ROOT_PCB=${SCRIPT_DIR}/Kicad/neotron-pico.kicad_pcb
BUILD_DIR=${SCRIPT_DIR}/docs
LAYERS=F.Cu,In1.Cu,In2.Cu,B.Cu,F.Mask,B.Mask,Edge.Cuts,F.Silkscreen,B.Silkscreen

# Does a build using kicad-cli

MY_DATE=$(git log -1 --format="%as")
if [ -z ${SOURCE_TAG+x} ]; then
    SOURCE_TAG=$(git describe --exact-match --tags 2> /dev/null || git rev-parse --short HEAD)
fi

DEFINES="-D date=${MY_DATE} -D version=${SOURCE_TAG}"

mkdir -p ${BUILD_DIR}
cd ${BUILD_DIR}


kicad-cli sch erc ${DEFINES} ${ROOT_SCH} --severity-warning
cat neotron-pico-erc.rpt
kicad-cli sch erc ${DEFINES} ${ROOT_SCH} --exit-code-violations --severity-error
kicad-cli sch export bom --output neotron-pico-bom-all.csv --fields '${DNP},LCSC Part#,Reference,Value,Footprint,${QUANTITY},${ITEM_NUMBER}' ${ROOT_SCH}
cat neotron-pico-bom-all.csv  | grep -e "QUANTITY" -e '^"0"' > neotron-pico-bom-fitted.csv
cat neotron-pico-bom-all.csv  | grep -e "QUANTITY" -e '^"0","C' > neotron-pico-bom-jlcpcb.csv
kicad-cli sch export pdf --output neotron-pico-sch.pdf ${DEFINES} ${ROOT_SCH}

kicad-cli pcb drc ${DEFINES} ${ROOT_PCB} --severity-warning
cat neotron-pico-drc.rpt
kicad-cli pcb drc ${DEFINES} ${ROOT_PCB} --exit-code-violations --severity-error
kicad-cli pcb export pos ${ROOT_PCB}
kicad-cli pcb export pdf -l ${LAYERS} --output neotron-pico-pcb.pdf ${DEFINES} ${ROOT_PCB}
mkdir -p gerbers
cd gerbers
kicad-cli pcb export drill ${ROOT_PCB}
kicad-cli pcb export gerbers -l ${LAYERS} ${DEFINES} ${ROOT_PCB}
zip ../neotron-pico-gerbers.zip *
cd ..
rm -rf gerbers

kicad-cli pcb render --output neotron-pico.jpg ${ROOT_PCB}
