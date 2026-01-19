from flask import Flask, request, jsonify
import os
import tempfile

app = Flask(__name__)

@app.route('/health')
def health():
    return jsonify({'status': 'healthy', 'service': 'docling'})

@app.route('/convert', methods=['POST'])
def convert():
    try:
        if 'file' not in request.files:
            return jsonify({'error': 'No file provided'}), 400

        file = request.files['file']

        # Save file temporarily
        with tempfile.NamedTemporaryFile(delete=False, suffix=os.path.splitext(file.filename)[1]) as tmp:
            file.save(tmp.name)

            # Import docling and convert
            from docling.document_converter import DocumentConverter
            converter = DocumentConverter()
            result = converter.convert(tmp.name)

            os.unlink(tmp.name)

            return jsonify({
                'status': 'success',
                'markdown': result.document.export_to_markdown()
            })
    except Exception as e:
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    print("Docling service starting on port 9000...")
    app.run(host='0.0.0.0', port=9000)
