import QtQuick 2.12
import QtQuick.Controls 2.12

Image{
	id: root

	property string color: "black"
	property string path: ""
	property int svgWidth: 24
	property int svgHeight: 24

	fillMode: Image.PreserveAspectFit

	function setSource() {
		const source = `data:image/svg+xml;utf8, <svg width="${this.svgWidth}" height="${this.svgHeight}" viewBox="0 0 24 24"><path d="${this.path}" fill="${this.color}"/></svg>`;
		this.source = source;
	}

	Component.onCompleted: setSource();
	onPathChanged:	setSource();
	onColorChanged: setSource();
	onSvgWidthChanged: setSource();
	onSvgHeightChanged: setSource();
}