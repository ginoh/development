(require 'package)                                                                                                              
                                                                                                                                
;; MELPA                                                                                                                        
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)                                                     
                                                                                                                                
;; package init                                                                                                                 
(package-initialize)                                                                                                            
                                                                                                                                
;; theme                                                                                                                        
(load-theme 'manoj-dark t)                                                                                                      
                                                                                                                                
;; global                                                                                                                       
(global-set-key "\C-h" 'delete-backward-char)                                                                                   
(global-set-key "\M-g" 'goto-line)                                                                                              
;; (global-set-key "\C-c t" 'toggle-truncate-lines)                                                                             
                                                                                                                                
;; indent                                                                                                                       
(setq-default indent-tabs-mode nil)                                                                                             
(setq-default tab-width 4)

;; bold bracket                                                                                                                 
(show-paren-mode t)                                                                                                             
                                                                                                                                
;; display columns                                                                                                              
(column-number-mode t)                                                                                                          
                                                                                                                                
;;                                                                                                                              
(setq-default truncate-lines t)                                                                                                 
(setq truncate-lines t)                                                                                                         
(setq truncate-partial-width-windows t)

;; js-indent                                                                                                                    
(setq js-indent-level 2)                                                                                                        
                                                                                                                                
(custom-set-variables                                                                                                           
 ;; custom-set-variables was added by Custom.                                                                                   
 ;; If you edit it by hand, you could mess it up, so be careful.                                                                
 ;; Your init file should contain only one such instance.                                                                       
 ;; If there is more than one, they won't work right.                                                                           
 '(package-selected-packages (quote (docker-compose-mode))))                                                                    
(custom-set-faces                                                                                                               
 ;; custom-set-faces was added by Custom.                                                                                       
 ;; If you edit it by hand, you could mess it up, so be careful.                                                                
 ;; Your init file should contain only one such instance.                                                                       
 ;; If there is more than one, they won't work right.                                                                           
 )

 