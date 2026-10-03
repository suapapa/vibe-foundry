import json
import sys

spillover_path = "/home/suapapa/.hermes/cache/spillover/chatcmpl-tool-8f5e4f859668ef02.txt"
target_path = "/home/suapapa/vibe-foundry/2026-10-03_Scooter/model.stl"

try:
    with open(spillover_path, 'r') as f:
        full_text = f.read()
    
    start_idx = full_text.find('{"result":')
    if start_idx == -1:
        print("Error: Could not find '{\"result\":' in spillover file.")
        sys.exit(1)
        
    end_idx = full_text.rfind('}')
    if end_idx == -1:
        print("Error: Could not find closing brace in spillover file.")
        sys.exit(1)
        
    json_str = full_text[start_idx:end_idx+1]
    data = json.loads(json_str)
    
    # The 'result' field is the JSON string of the tool output
    inner_json_str = data["result"]
    inner_data = json.loads(inner_json_str)
    
    # The 'content' field in the tool output contains the STL data
    stl_content = inner_data["content"]
    
    with open(target_path, 'w') as f_out:
        f_out.write(stl_content)
        
    print(f"SUCCESS: Wrote STL to {target_path}")
except Exception as e:
    print(f"FAILURE: {e}")
    sys.exit(1)
