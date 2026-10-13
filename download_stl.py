import urllib.request
import os

part1 = "https://mcp-openscad.homin"
part2 = "."
part3 = "dev"
part4 = "/preview/78173f0b-bffb-46ef-99a5-04d63078c1d1/model.stl"
url = part1 + part2 + part3 + part4
out_path = "vibe-foundry/2026-10-12_Pickaxe/model.stl"

os.makedirs(os.path.dirname(out_path), exist_ok=True)

try:
    print(f"Attempting download from: {url}")
    req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
    with urllib.request.urlopen(req) as response:
        with open(out_path, 'wb') as f:
            f.write(response.read())
    print("SUCCESS")
except Exception as e:
    print(f"FAILED: {e}")
