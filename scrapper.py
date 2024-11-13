import requests

def fetch_raw_markdown():
    url = "https://raw.githubusercontent.com/rockerBOO/awesome-neovim/refs/heads/main/README.md"
    response = requests.get(url)
    return response.text

def extract_colorscheme_links(markdown_content):
    results = []
    in_colorscheme_section = False

    for line in markdown_content.split('\n'):
        # Check for the section header
        if line.strip().startswith('### Tree-sitter Supported Colorscheme'):
            in_colorscheme_section = True
            continue

        # Exit if we hit the next section
        if in_colorscheme_section and line.strip().startswith('### Colorscheme Creation'):
            break

        # Parse links in the colorscheme section
        if in_colorscheme_section and line.strip().startswith('- ['):
            try:
                # Extract the link part
                link_start = line.index('(', line.index('/', line.index('/', line.index('/')))) + 1
                link_end = line.index(')', link_start)
                link = line[link_start:link_end]

                # Extract the description part (after the link)
                desc_start = line.index(')', link_end) + 1
                description = line[desc_start:].strip(' -')

                # Extract the repo name
                name_start = line.index('[') + 1
                name_end = line.index(']')
                name = line[name_start:name_end]

                results.append({
                    'name': name,
                    'url': link,
                    'description': description
                })
            except ValueError:
                continue
    return results

def generate_lua_file(themes):
    lua_content = ["return {",]
    for theme in themes:
        name = theme['name'].replace("'", "\\'")
        url = theme['url'].replace("'", "\\'")
        desc = theme['description'].replace("'", "\\'")

        lua_content.extend({
            f"  {{ name='{name}', url='{url}', description='{desc}' }},",
        })
    lua_content.append("}")
    return "\n".join(lua_content)

def main():
    try:
        markdown_content = fetch_raw_markdown()
        links = extract_colorscheme_links(markdown_content)
        lua_content = generate_lua_file(links)

        with open("theme_list.lua", "w", encoding='utf-8') as file:
            file.write(lua_content)

        print(f"Found {len(links)} colorschemes:\n")
        for link in links:
            print(f"Name: {link['name']}")
            print(f"URL: {link['url']}")
            if link['description']:
                print(f"Description: {link['description']}")
            print()

    except requests.RequestException as e:
        print(f"Error fetching markdown: {e}")
    except Exception as e:
        print(f"Error processing markdown: {e}")

if __name__ == "__main__":
    main()
