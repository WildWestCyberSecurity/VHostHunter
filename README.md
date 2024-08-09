# 🕵️‍♂️ VHostHunter

**VHostHunter** is a powerful 🛠️ Bash script for automated virtual host discovery using `ffuf`. Uncover hidden subdomains with customizable filters for size, HTTP status codes, and word counts. Supports both HTTP and HTTPS, with options for target IP and Host header manipulation. Perfect for penetration testers 🕵️‍♂️ aiming for efficient recon. #Pentesting #Recon 🚀

## ✨ Features

- 🚀 **Automated VHost Discovery:** Quickly uncover hidden subdomains and virtual hosts.
- 🎛️ **Customizable Filters:** Filter results by response size, HTTP status codes, and word count.
- 🌐 **Supports HTTP & HTTPS:** Seamlessly toggle between protocols.
- 🛠️ **Target IP Manipulation:** Specify a target IP for Host header testing.
- 💾 **Output to File:** Save results for later analysis and reporting.

## 📋 Usage

```
./vhosthunter.sh <target_domain> <wordlist> [-ip target_ip] [-fs filter_size] [-fc filter_code] [-fw filter_word] [-o output_file]
```

### ⚙️ Options

- `-ip target_ip`: 🖥️ Specify the target IP for Host header testing.
- `-fs filter_size`: 📏 Filter responses by size (comma-separated).
- `-fc filter_code`: 📋 Filter responses by HTTP status code (comma-separated).
- `-fw filter_word`: 🔠 Filter responses by word count (comma-separated).
- `-o output_file`: 💾 Save the results to a specified file.

### 🛡️ Example

```
./vhosthunter.sh example.com wordlist.txt -ip 192.168.1.1 -fc 404 -o results.txt
```

## 🔗 Resources

- [ffuf Documentation](https://github.com/ffuf/ffuf)
- [More about VHostHunter](https://github.com/WildWestCyberSecurity/VHostHunter)

## 🙌 Contributing

Feel free to open issues or submit pull requests. Contributions are always welcome!

## 📝 License

This project is licensed under the MIT License.
