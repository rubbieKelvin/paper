import QtQuick 2.15
import QtQuick.Controls 2.15

Image{
	id: root

	property string color: "black"
	property variant path: ""
	property int svgWidth: 24
	property int svgHeight: 24
	property string pathProp: ""

	fillMode: Image.PreserveAspectFit

	function setPath() {
		let path = this.path;

		if (typeof path === "string") {
			path = [path];
		}

		const color = this.color;
		const props = this.pathProp;
		const svg	= `data:image/svg+xml;utf8,
			<svg width="${this.svgWidth}" height="${this.svgHeight}" viewBox="0 0 24 24">
				${
					path.map(
						function (p) {
							return `<path d="${p}" fill="${color}" ${props}/>`;
						}
					)
				}
			</svg>`;
		this.source = svg;
	}

	Component.onCompleted: setPath();
	onColorChanged: setPath();
	onSvgWidthChanged: setPath();
	onSvgHeightChanged: setPath();
}